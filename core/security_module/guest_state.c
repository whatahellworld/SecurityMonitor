/**	\file guest_state.c
*	\brief High-level facilities to get guest VM's information.
*/
#include <guest_state.h>
#include <vmcs.h>
#include <guest_IA32ePage.h>

GPA_t get_page_table_base_GPA()
{
	GPA_t cr3Value;
	cr3Value = get_guest_cr3_value();
	cr3Value = cr3Value & CR3_MASK;
	return cr3Value;
}


GPA_t get_ept_base_HPA()
{
	GPA_t eptpValue;
	eptpValue = get_guest_eptp_value();
	eptpValue = eptpValue & EPTP_MASK;

	return eptpValue;
}

void traverseGuestPages(const VMID_t vmid, const APPID_t appID, const GPA_t startGPAofPageTable, void* (*do_something)(const VMID_t vmID, const APPID_t appID, GPA_t gpa))
{
	traverseIA32ePages(vmid, appID, startGPAofPageTable, do_something);
}