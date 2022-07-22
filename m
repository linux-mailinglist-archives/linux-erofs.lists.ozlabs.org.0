Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B40757E6D4
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 20:47:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LqJMs1DWrz307g
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 04:47:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=globalkingprojectmanagement.com header.i=@globalkingprojectmanagement.com header.a=rsa-sha256 header.s=api header.b=NhOH3o+C;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=IMG6V1cC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=globalkingprojectmanagement.com (client-ip=67.227.87.8; helo=n8.mxout.mta4.net; envelope-from=outreach@globalkingprojectmanagement.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=globalkingprojectmanagement.com header.i=@globalkingprojectmanagement.com header.a=rsa-sha256 header.s=api header.b=NhOH3o+C;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=IMG6V1cC;
	dkim-atps=neutral
Received: from n8.mxout.mta4.net (n8.mxout.mta4.net [67.227.87.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LqJMn6xxhz2yL6
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 04:47:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; d=globalkingprojectmanagement.com; s=api;
	c=relaxed/simple; t=1658515626;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=XWUorrNSlogvurVbnyZYiD6FnDOXeACJpeohZd9M+2k=;
	b=NhOH3o+Cdq39dRjrO8oI2WrmjEox6u7gWIb7VmTsM8xNniHEOwgACqlDsQqRLLMus3f1HcvtBKy
	g+0YIgljdFbFlIeb0nGMb27ysO7WVA6echeZ1yQxd+hve5iEmJG+UV2KV4izLkFjWJ71WlJR31i7J
	AfhKPI42laW5obCjdVU=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1658515626;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=XWUorrNSlogvurVbnyZYiD6FnDOXeACJpeohZd9M+2k=;
	b=IMG6V1cC/rtc0pAU8MTk5XvXqCAr6p1vVZ5kNmefHHxZXmQb93/su0pXkY3QQtrkCjGG9j/xWJ/
	ThdGSiisaPKJyuDofDIVJYwsuYcL9ZqiH+yYspGoBlcVTmu7BhgCvr5aPXTx3fV/VpiJ7JGi8M+ad
	J3HOBgU/veis3AUtFMo=
From: Global King Project Management
	<outreach@globalkingprojectmanagement.com>
Date: Fri, 22 Jul 2022 18:47:06 +0000
Subject: invitation for Project Monitoring and Evaluation with Data Management
 and Analysis Course
Message-Id: <4uhf96nx1rdm.Fik9OYrPP3UZu62Lkprfbw2@tracking.globalkingprojectmanagement.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: Fik9OYrPP3UZu62Lkprfbw2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfImvepwr1NfeuOfwVfH+T/g9yx/gn23WKzQ=="
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Reply-To: outreach@globalkingprojectmanagement.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-eZCfImvepwr1NfeuOfwVfH+T/g9yx/gn23WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

wqANCjxodHRwOi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNvbS90
cmFja2luZy9jbGljaz9kPU55MEhRT19ESm14UWowOUtvSTVRTDRHSWZ6UGJ0azVCajAxR2xa
UUlLa2h1Q29fUm1OLWpjT3QzYk9TczdsVXBoM01yQmIweG9yWS1panVNcVdxZVM5TnM3T3h6
eEN4bHl2YlhhZFIxOXZBZmFmSXJLLThXa2JvNWVWSzluLUk5UzF1Sk9NMThaTWpwc0VPRXo3
em5uYXA4UHVrTzh0ZkVDWnFhaWlpeHljWHAwPg0KUHJvamVjdCANCk1vbml0b3JpbmcgYW5k
IEV2YWx1YXRpb24gd2l0aCBEYXRhIE1hbmFnZW1lbnQgYW5kIEFuYWx5c2lzIENvdXJzZSBB
dWd1c3QxNSAyMDIyIA0KdG8gQXVndXN0IDI2IDIwMjIgTW9tYmFzYSBLZW55YcKgVmVudWU6
wqAgwqBPbnNpdGUgTW9tYmFzYSBvciBOYWlyb2JpIEtlbnlhIG9yIG9ubGluZSANCnBsYXRm
b3JtLsKgUmVnaXN0cmF0aW9uOsKgIA0KPGh0dHA6Ly90cmFja2luZy5nbG9iYWxraW5ncHJv
amVjdG1hbmFnZW1lbnQuY29tL3RyYWNraW5nL2NsaWNrP2Q9b012QURhUlRPSUFtRnVoeUsw
ZnRGcy1WOWEzbm0yQnpuNUk1OVZkZ25WM0VKdENQTlBlaEZIdlNHcjN2YzVuWVFnQlNLOFk5
NFJ1UUN0eXA3ZUNXZmdJN2hDckJrQU41N0lBa1hzMmRjRWtGOVNJeGh4OWJHTVVIdGY4WXpO
aDNJMHp5R1VQbDNsSUtodm9IVG5BWk9kWFV0d2kzMFpRc3RPODVhUGNKLVdCSDc3ZDRUSExZ
RGpEM1QwbnRXYXNBbGcyPg0KVXNlIHRoaXMgbGluayANCnRvIHJlZ2lzdGVywqANCjxodHRw
Oi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNvbS90cmFja2luZy9j
bGljaz9kPUZ2bTN1MDZSYlZuN204RmNON0R1UHNtUjExVWl1a0hhUS0wUVl3T2F2ZGlsWGlB
Tm8xeVliTDZIdXJMRlcxZ3NXTk9xRVl2WDB0YkxOWWFFLUpNMnBVOEJtbWpiNG9NV21PdHhw
d1duRGxCbkgzTWxnRHFtUUlFSXJ2ZThVMjZIUW1iWjNJMEgzTHpqTjJaTGhLbDA0LW1qMlR0
ZmpWZm1EZnUzeXlmRl9ERnByMWdYOHVIeEVCVXFZOEEwMnpXTkNjOE1XX1FFNXA1ZWlGdkxa
SU5TVkJxbEJUNlpCOVFaUF9IT0ctX1VBbjBJMkV1SzY3Z3VfRTdnYWtiamwwck5ic1ZjWTNN
bzAzdkYydHpyTmd1WlNNYzE+DQpEb3dubG9hZCBBZG1pc3Npb24gRm9ybTrCoA0KPGh0dHA6
Ly90cmFja2luZy5nbG9iYWxraW5ncHJvamVjdG1hbmFnZW1lbnQuY29tL3RyYWNraW5nL2Ns
aWNrP2Q9d28yYVgtX2g1MmVEdUV0MTk0eFlPNTJpWFI1MjZXQkhYTmNvay1lakRKWGZzUXJP
WnlYdTBfS0REUUlMa19yaHZBTUVCVlJERzExTS01ZjNHY2U1dmJEQTV0bmJESmdrSWlpRUNq
dm5Cc2RINFdEVV81dmZIdlRqY3RLTTNjdWNlTllKV3doSmdQWk01cS1DQWozVk1tdVo5TnpT
T3lyUXdXVFJTaFpxeXByY0lPcjFPQmZVN1JPdl8yR2VzTUNNUXcyPg0KRG93bmxvYWQgT3Vy
IA0KQ2FsZW5kYXI6wqANCjxodHRwOi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5h
Z2VtZW50LmNvbS90cmFja2luZy9jbGljaz9kPU55MEhRT19ESm14UWowOUtvSTVRTDRHSWZ6
UGJ0azVCajAxR2xaUUlLa2dxcXk3UUtBVkJrMExSd2YyMDExY1dBUzZnTEd3ZUJtM0xPNXUw
dFVpSk1objQ1bGQ0eThUd0k1VjZxLVJGYWQ3dzVvdDF0T2FFZndaRU1ZUmJmYk9ncVprWTRR
ZE9nSmV6ZTBoeThycE5IMWh3Vlp6TFozYURaa0tNdGh6NjlLV3AwPg0KVmlldyBhbGwgb3Vy
IA0KY291cnNlc8KgDQo8aHR0cDovL3RyYWNraW5nLmdsb2JhbGtpbmdwcm9qZWN0bWFuYWdl
bWVudC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1qemRvaDFDVFo1bThhdnoyakdKNGJ2b3RMQVNo
Q0JoNmp0UkVNX1djN0wwaDNVUGlrMndjckNqd0tCazFhYmRJUWlEVDhpS3R4cFRhYzRIQnd3
dURlR2NnaV9PZlhLRHlOOGppYnk4RXdXQUs0b05DS2NCYUFpWGhEc3VValpBYnFRSXZWUVUt
YmdMZV91TU1vbXdHd0FfWFFKc1d4b2pnTnJHQUVIMkY0N2M0OXU0MTFkSlIxdlRRNVJ4eGxo
Mk9jUUpaSkx5dHhDdzg3MTh4Y3h3LUNaRVdULWUwNTBsNkVvdnJNY0FRSGdPbkNGVEJ4bUpt
VXdKcHg1S3BYSm1La2dBUkpwbHkweU9YZGlMV2N0UmIyYVZzSDE5ZTM4UGx5M3pkN1JPLTYw
dGpiWnlzcnlnc2FaUG9VZnJpYXpobkVnMj4NClJlYWNoIHVzIA0KdGhyb3VnaCBXaGF0c0Fw
cMKgUmVhY2ggdXM6IA0KdHJhaW5pbmdAZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50Lm9y
ZyAvICsyNTQgMTE0IDgzMCANCjg4OQ0KwqBBYm91dCB0aGUgDQpjb3Vyc2UNClRoaXMgDQpp
cyBhIGNvbXByZWhlbnNpdmUgMTAgZGF5cyBNJkUgY291cnNlIHRoYXQgY292ZXJzIHRoZSBw
cmluY2lwbGVzIGFuZCANCnByYWN0aWNlcyBmb3IgcmVzdWx0cy1iYXNlZCBtb25pdG9yaW5n
IGFuZCBldmFsdWF0aW9uIGZvciB0aGUgZW50aXJlIHByb2plY3QgDQpsaWZlIGN5Y2xlLiBU
aGlzIGNvdXJzZSBlcXVpcHMgcGFydGljaXBhbnRzIHdpdGggc2tpbGxzIGluIHNldHRpbmcg
dXAgYW5kIA0KaW1wbGVtZW50aW5nIHJlc3VsdHMtYmFzZWQgbW9uaXRvcmluZyBhbmQgZXZh
bHVhdGlvbiBzeXN0ZW1zIGluY2x1ZGluZyBNJkUgDQpkYXRhIG1hbmFnZW1lbnQsIGFuYWx5
c2lzLCBhbmQgcmVwb3J0aW5nLiBUaGUgcGFydGljaXBhbnRzIHdpbGwgYmVuZWZpdCBmcm9t
IHRoZSANCmxhdGVzdCBNJkUgdGhpbmtpbmcgYW5kIHByYWN0aWNlcyBpbmNsdWRpbmcgdGhl
IHJlc3VsdHMgYW5kIHBhcnRpY2lwYXRvcnkgDQphcHByb2FjaGVzLiBUaGlzIGNvdXJzZSBp
cyBkZXNpZ25lZCB0byBlbmFibGUgdGhlIHBhcnRpY2lwYW50cyBiZWNvbWUgZXhwZXJ0cyBp
biANCm1vbml0b3JpbmcgYW5kIGV2YWx1YXRpbmcgdGhlaXIgZGV2ZWxvcG1lbnQgcHJvamVj
dHMuIFRoZSBjb3Vyc2UgY292ZXJzIGFsbCB0aGUgDQprZXkgZWxlbWVudHMgb2YgYSByb2J1
c3QgTSZFIHN5c3RlbSBjb3VwbGVkIHdpdGggYSBwcmFjdGljYWwgcHJvamVjdCB0byANCmls
bHVzdHJhdGUgdGhlIE0mRSBjb25jZXB0cy7CoA0KVGFyZ2V0IA0KUGFydGljaXBhbnRzDQpU
aGlzIA0KY291cnNlIGlzIGRlc2lnbmVkIGZvciByZXNlYXJjaGVycywgcHJvamVjdCBzdGFm
ZiwgZGV2ZWxvcG1lbnQgcHJhY3RpdGlvbmVycywgDQptYW5hZ2VycyBhbmQgZGVjaXNpb24g
bWFrZXJzIHdobyBhcmUgcmVzcG9uc2libGUgZm9yIHByb2plY3QsIHByb2dyYW0gb3IgDQpv
cmdhbml6YXRpb24tbGV2ZWwgTSZFLiBUaGUgY291cnNlIGFpbXMgdG8gZW5oYW5jZSB0aGUg
c2tpbGxzIG9mIA0KcHJvZmVzc2lvbmFscyB3aG8gbmVlZCB0byByZXNlYXJjaCwgc3VwZXJ2
aXNlLCBtYW5hZ2UsIHBsYW4sIGltcGxlbWVudCwgbW9uaXRvciANCmFuZCBldmFsdWF0ZSBk
ZXZlbG9wbWVudCBwcm9qZWN0cy4NCkNvdXJzZSANCmR1cmF0aW9uDQoxMCANCmRheXMNCkNv
dXJzZSANCm9iamVjdGl2ZXMNCkRldmVsb3AgcHJvamVjdCANCiAgcmVzdWx0cyBsZXZlbHMN
CkRlc2lnbiBhIHByb2plY3QgDQogIHVzaW5nIGxvZ2ljYWwgZnJhbWV3b3JrDQpEZXZlbG9w
IA0KICBpbmRpY2F0b3JzIGFuZCB0YXJnZXRzIGZvciBlYWNoIHJlc3VsdCBsZXZlbA0KVHJh
Y2sgDQogIHBlcmZvcm1hbmNlIGluZGljYXRvcnMgb3ZlciB0aGUgbGlmZSBvZiB0aGUgcHJv
amVjdA0KRXZhbHVhdGlvbiBhIA0KICBwcm9qZWN0IGFnYWluc3QgdGhlIHNldCByZXN1bHRz
DQpEZXZlbG9wIGFuZCANCiAgaW1wbGVtZW50IE0mRSBzeXN0ZW1zDQpEZXZlbG9wIGEgDQog
IGNvbXByZWhlbnNpdmUgbW9uaXRvcmluZyBhbmQgZXZhbHVhdGlvbiBwbGFuDQpVc2UgZGF0
YSANCiAgYW5hbHlzaXMgc29mdHdhcmUgKFN0YXRhL1NQU1MvUikNCkNvbGxlY3QgZGF0YSAN
CiAgdXNpbmcgbW9iaWxlIGRhdGEgY29sbGVjdGlvbiB0b29scw0KQ2FycnlvdXQgaW1wYWN0
IA0KICBldmFsdWF0aW9uDQpVc2UgR0lTIHRvIA0KICBhbmFseXplIGFuZCBzaGFyZSBwcm9q
ZWN0IGRhdGENCkNvdXJzZSANCk91dGxpbmUNCkludHJvZHVjdGlvbiANCnRvIFJlc3VsdHMg
QmFzZWQgUHJvamVjdCBNYW5hZ2VtZW50DQpGdW5kYW1lbnRhbHMgb2YgDQogIFJlc3VsdHMg
QmFzZWQgTWFuYWdlbWVudA0KV2h5IGlzIFJCTSANCiAgaW1wb3J0YW50Pw0KUmVzdWx0cyBi
YXNlZCANCiAgbWFuYWdlbWVudCB2cyB0cmFkaXRpb25hbCBwcm9qZWN0cyBtYW5hZ2VtZW50
DQpSQk0gTGlmZWN5Y2xlIA0KICAoc2V2ZW4gcGhhc2VzKQ0KQXJlYXMgb2YgZm9jdXMgDQog
IG9mIFJCTQ0KRnVuZGFtZW50YWxzIA0Kb2YgTW9uaXRvcmluZyBhbmQgRXZhbHVhdGlvbg0K
RGVmaW5pdGlvbiBvZiANCiAgTW9uaXRvcmluZyBhbmQgRXZhbHVhdGlvbg0KV2h5IE1vbml0
b3JpbmcgDQogIGFuZCBFdmFsdWF0aW9uIGlzIGltcG9ydGFudA0KS2V5IHByaW5jaXBsZXMg
DQogIGFuZCBjb25jZXB0cyBpbiBNJkUNCk0mRSBpbiANCiAgcHJvamVjdCBsaWZlY3ljbGUN
ClBhcnRpY2lwYXRvcnkgDQogIE0mRQ0KUHJvamVjdCANCkFuYWx5c2lzDQpTaXR1YXRpb24g
DQogIEFuYWx5c2lzDQpOZWVkcyANCiAgQXNzZXNzbWVudA0KU3RyYXRlZ3kgDQogIEFuYWx5
c2lzDQpEZXNpZ24gDQpvZiBSZXN1bHRzIGluIE1vbml0b3JpbmcgYW5kIEV2YWx1YXRpb24N
ClJlc3VsdHMgY2hhaW4gDQogIGFwcHJvYWNoZXM6IEltcGFjdCwgb3V0Y29tZXMsIG91dHB1
dHMgYW5kIGFjdGl2aXRpZXMNClJlc3VsdHMgDQogIGZyYW1ld29yaw0KTSZFIGNhdXNhbCAN
CiAgcGF0aHdheQ0KUHJpbmNpcGxlcyBvZiANCiAgcGxhbm5pbmcsIG1vbml0b3JpbmcgYW5k
IGV2YWx1YXRpbmcgZm9yIHJlc3VsdHMNCk0mRSANCkluZGljYXRvcnMNCkluZGljYXRvcnMg
DQogIGRlZmluaXRpb24NCkluZGljYXRvciANCiAgbWV0cmljcw0KTGlua2luZyANCiAgaW5k
aWNhdG9ycyB0byByZXN1bHRzDQpJbmRpY2F0b3IgDQogIG1hdHJpeA0KVHJhY2tpbmcgb2Yg
DQogIGluZGljYXRvcnMNCkxvZ2ljYWwgDQpGcmFtZXdvcmsgQXBwcm9hY2gNCkxGQSDigJMg
QW5hbHlzaXMgDQogIGFuZCBQbGFubmluZyBwaGFzZQ0KRGVzaWduIG9mIA0KICBsb2dmcmFt
ZQ0KUmlzayByYXRpbmcgaW4gDQogIGxvZ2ZyYW1lDQpIb3Jpem9udGFsIGFuZCANCiAgdmVy
dGljYWwgbG9naWMgaW4gbG9nZnJhbWUNClVzaW5nIGxvZ2ZyYW1lIA0KICB0byBjcmVhdGUg
c2NoZWR1bGVzOiBBY3Rpdml0eSBhbmQgQnVkZ2V0IHNjaGVkdWxlcw0KVXNpbmcgbG9nZnJh
bWUgDQogIGFzIGEgcHJvamVjdCBtYW5hZ2VtZW50IHRvb2wNClRoZW9yeSANCm9mIENoYW5n
ZQ0KT3ZlcnZpZXcgb2YgDQogIHRoZW9yeSBvZiBjaGFuZ2UNCkRldmVsb3BpbmcgDQogIHRo
ZW9yeSBvZiBjaGFuZ2UNClRoZW9yeSBvZiBDaGFuZ2UgDQogIHZzIExvZyBGcmFtZQ0KQ2Fz
ZSBzdHVkeTogDQogIFRoZW9yeSBvZiBjaGFuZ2UNCk0mRSANClN5c3RlbXMNCldoYXQgaXMg
YW4gDQogIE0mRSBTeXN0ZW0/DQpFbGVtZW50cyBvZiANCiAgTSZFIFN5c3RlbQ0KU3RlcHMg
Zm9yIA0KICBkZXZlbG9waW5nIFJlc3VsdHMgYmFzZWQgTSZFIFN5c3RlbQ0KTSZFIA0KUGxh
bm5pbmcNCkltcG9ydGFuY2Ugb2YgYW4gDQogIE0mRSBQbGFuDQpEb2N1bWVudGluZyANCiAg
TSZFIFN5c3RlbSBpbiB0aGUgTSZFIFBsYW4NCkNvbXBvbmVudHMgb2YgYW4gDQogIE0mRSBQ
bGFuLU1vbml0b3JpbmcsIEV2YWx1YXRpb24sIERhdGEgbWFuYWdlbWVudCwgDQogIFJlcG9y
dGluZw0KVXNpbmcgTSZFIA0KICBQbGFuIHRvIGltcGxlbWVudCBNJkUgaW4gYSBQcm9qZWN0
DQpNJkUgcGxhbiB2cyANCiAgUGVyZm9ybWFuY2UgTWFuYWdlbWVudCBQbGFuIChQTVApDQpC
YXNlIA0KU3VydmV5IGluIFJlc3VsdHMgYmFzZWQgTSZFDQpJbXBvcnRhbmNlIG9mIA0KICBi
YXNlbGluZSBzdHVkaWVzDQpQcm9jZXNzIG9mIA0KICBjb25kdWN0aW5nIGJhc2VsaW5lIHN0
dWRpZXMNCkJhc2VsaW5lIHN0dWR5IA0KICB2cyBldmFsdWF0aW9uDQpQcm9qZWN0IA0KUGVy
Zm9ybWFuY2UgRXZhbHVhdGlvbg0KUHJvY2VzcyBhbmQgDQogIHByb2dyZXNzIGV2YWx1YXRp
b25zDQpFdmFsdWF0aW9uIA0KICByZXNlYXJjaCBkZXNpZ24NCkV2YWx1YXRpb24gDQogIHF1
ZXN0aW9ucw0KRXZhbHVhdGlvbiANCiAgcmVwb3J0IERpc3NlbWluYXRpb24NCk0mRSANCkRh
dGEgTWFuYWdlbWVudA0KRGlmZmVyZW50IA0KICBzb3VyY2VzIG9mIE0mRSBkYXRhDQpRdWFs
aXRhdGl2ZSBkYXRhIA0KICBjb2xsZWN0aW9uIG1ldGhvZHMNClF1YW50aXRhdGl2ZSANCiAg
ZGF0YSBjb2xsZWN0aW9uIG1ldGhvZHMNClBhcnRpY2lwYXRvcnkgDQogIG1ldGhvZHMgb2Yg
ZGF0YSBjb2xsZWN0aW9uDQpEYXRhIFF1YWxpdHkgDQogIEFzc2Vzc21lbnQNCk0mRSANClJl
c3VsdHMgVXNlIGFuZCBEaXNzZW1pbmF0aW9uDQpTdGFrZWhvbGRlcuKAmXMgDQogIGluZm9y
bWF0aW9uIG5lZWRzDQpVc2Ugb2YgTSZFIA0KICByZXN1bHRzIHRvIGltcHJvdmUgYW5kIHN0
cmVuZ3RoZW4gcHJvamVjdHMNClVzZSBvZiBNJkUgDQogIExlc3NvbnMgbGVhcm50IGFuZCBC
ZXN0IFByYWN0aWNlcw0KT3JnYW5pemF0aW9uIA0KICBrbm93bGVkZ2UgY2hhbXBpb25zDQpN
JkUgDQogIHJlcG9ydGluZyBmb3JtYXQNCk0mRSByZXN1bHRzIA0KICBjb21tdW5pY2F0aW9u
IHN0cmF0ZWdpZXMNCkdlbmRlciANClBlcnNwZWN0aXZlIGluIE0mRQ0KSW1wb3J0YW5jZSBv
ZiANCiAgZ2VuZGVyIGluIE0mRQ0KSW50ZWdyYXRpbmcgDQogIGdlbmRlciBpbnRvIHByb2dy
YW0gbG9naWMNClNldHRpbmcgZ2VuZGVyIA0KICBzZW5zaXRpdmUgaW5kaWNhdG9ycw0KQ29s
bGVjdGluZyANCiAgZ2VuZGVyIGRpc2FnZ3JlZ2F0ZWQgZGF0YQ0KQW5hbHl6aW5nIA0KICBN
JkUgZGF0YSBmcm9tIGEgZ2VuZGVyIHBlcnNwZWN0aXZlDQpBcHByYWlzYWwgb2YgDQogIHBy
b2plY3RzIGZyb20gYSBnZW5kZXIgcGVyc3BlY3RpdmUNCkRhdGEgDQpDb2xsZWN0aW9uIFRv
b2xzIGFuZCBUZWNobmlxdWVzDQpTb3VyY2VzIG9mIA0KICBNJkUgZGF0YSDigJNwcmltYXJ5
IGFuZCBzZWNvbmRhcnkNClNhbXBsaW5nIGR1cmluZyANCiAgZGF0YSBjb2xsZWN0aW9uDQpR
dWFsaXRhdGl2ZSBkYXRhIA0KICBjb2xsZWN0aW9uIG1ldGhvZHMNClF1YW50aXRhdGl2ZSAN
CiAgZGF0YSBjb2xsZWN0aW9uIG1ldGhvZHMNClBhcnRpY2lwYXRvcnkgDQogIGRhdGEgY29s
bGVjdGlvbiBtZXRob2RzDQpJbnRyb2R1Y3Rpb24gdG8gDQogIGRhdGEgdHJpYW5ndWxhdGlv
bg0KRGF0YSANClF1YWxpdHkNCldoYXQgaXMgZGF0YSANCiAgcXVhbGl0eT8NCldoeSBkYXRh
IA0KICBxdWFsaXR5Pw0KRGF0YSBxdWFsaXR5IA0KICBzdGFuZGFyZHMNCkRhdGEgZmxvdyBh
bmQgDQogIGRhdGEgcXVhbGl0eQ0KRGF0YSBRdWFsaXR5IA0KICBBc3Nlc3NtZW50cw0KTSZF
IHN5c3RlbSANCiAgZGVzaWduIGZvciBkYXRhIHF1YWxpdHkNCklDVCANCmluIE1vbml0b3Jp
bmcgYW5kIEV2YWx1YXRpb24NCk1vYmlsZSBiYXNlZCANCiAgZGF0YSBjb2xsZWN0aW9uIHVz
aW5nIE9ESw0KRGF0YSANCiAgdmlzdWFsaXphdGlvbiAtIGluZm8gZ3JhcGhpY3MgYW5kIGRh
c2hib2FyZHMNClVzZSBvZiBJQ1QgdG9vbHMgDQogIGZvciBSZWFsLXRpbWUgbW9uaXRvcmlu
ZyBhbmQgZXZhbHVhdGlvbg0KUXVhbGl0YXRpdmUgDQpEYXRhIEFuYWx5c2lzDQpQcmluY2lw
bGVzIG9mIA0KICBxdWFsaXRhdGl2ZSBkYXRhIGFuYWx5c2lzDQpEYXRhIHByZXBhcmF0aW9u
IA0KICBmb3IgcXVhbGl0YXRpdmUgYW5hbHlzaXMNCkxpbmtpbmcgYW5kIA0KICBpbnRlZ3Jh
dGluZyBtdWx0aXBsZSBkYXRhIHNldHMgaW4gZGlmZmVyZW50IGZvcm1zDQpUaGVtYXRpYyAN
CiAgYW5hbHlzaXMgZm9yIHF1YWxpdGF0aXZlIGRhdGENCkNvbnRlbnQgYW5hbHlzaXMgDQog
IGZvciBxdWFsaXRhdGl2ZSBkYXRhDQpNYW5pcHVsYXRpb24gYW5kIA0KICBhbmFseXNpcyBv
ZiBkYXRhIHVzaW5nIE5WaXZvDQpRdWFudGl0YXRpdmUgDQpEYXRhIEFuYWx5c2lzIOKAkyAo
VXNpbmcgU1BTUy9TdGF0YSkNCkludHJvZHVjdGlvbiB0byANCiAgc3RhdGlzdGljYWwgY29u
Y2VwdHMNCkNyZWF0aW5nIA0KICB2YXJpYWJsZXMgYW5kIGRhdGEgZW50cnkNCkRhdGEgDQog
IHJlY29uc3RydWN0aW9uDQpWYXJpYWJsZXMgDQogIG1hbmlwdWxhdGlvbg0KRGVzY3JpcHRp
dmUgDQogIHN0YXRpc3RpY3MNClVuZGVyc3RhbmRpbmcgDQogIGRhdGEgd2VpZ2h0aW5nDQpJ
bmZlcmVudGlhbCANCiAgc3RhdGlzdGljczogaHlwb3RoZXNpcyB0ZXN0aW5nLCBULXRlc3Qs
IEFOT1ZBLCByZWdyZXNzaW9uIA0KICBhbmFseXNpcw0KSW1wYWN0IA0KQXNzZXNzbWVudA0K
SW50cm9kdWN0aW9uIHRvIA0KICBpbXBhY3QgZXZhbHVhdGlvbg0KQXR0cmlidXRpb24gaW4g
DQogIGltcGFjdCBldmFsdWF0aW9uDQpFc3RpbWF0aW9uIG9mIA0KICBjb3VudGVyZmFjdHVh
bA0KSW1wYWN0IA0KICBldmFsdWF0aW9uIG1ldGhvZHM6IERvdWJsZSBkaWZmZXJlbmNlLCBQ
cm9wZW5zaXR5IHNjb3JlIA0KICBtYXRjaGluZw0KR0lTIA0KaW4gTSZFDQpJbnRyb2R1Y3Rp
b24gdG8gDQogIEdJUyBpbiBNJkUNCkdJUyBhbmFseXNpcyBhbmQgDQogIG1hcHBpbmcgdGVj
aG5pcXVlcw0KRGF0YSBwcmVwYXJhdGlvbiANCiAgZm9yIGdlb3NwYXRpYWwgYW5hbHlzaXMN
Ckdlb3NwYXRpYWwgDQogIGFuYWx5c2lzIHVzaW5nIEdJUyBzb2Z0d2FyZSAoUUdJUykNCsKg
DQpHZW5lcmFsIA0KTm90ZXMNCsK3wqDCoMKgwqDCoMKgwqDCoCANCkFsbCBvdXIgY291cnNl
cyANCmNhbiBiZSBUYWlsb3ItbWFkZSB0byBwYXJ0aWNpcGFudHMgbmVlZHMNClRoZSBwYXJ0
aWNpcGFudCANCiAgbXVzdCBiZSBjb252ZXJzYW50IHdpdGggRW5nbGlzaA0KwqBQcmVzZW50
YXRpb25zIA0KICBhcmUgd2VsbCBndWlkZWQsIHByYWN0aWNhbCBleGVyY2lzZXMsIHdlYi1i
YXNlZCB0dXRvcmlhbHMsIGFuZCBncm91cCB3b3JrLiBPdXIgDQogIGZhY2lsaXRhdG9ycyBh
cmUgZXhwZXJ0c8Kgd2l0aCBtb3JlIHRoYW4gMTB5ZWFycyBvZiANCiAgZXhwZXJpZW5jZQ0K
wqBVcG9uIA0KICBjb21wbGV0aW9uIG9mIHRyYWluaW5nLCB0aGUgcGFydGljaXBhbnQgd2ls
bCBiZSBpc3N1ZWQgd2l0aCBhIEdsb2JhbCBLaW5nIA0KICBQcm9qZWN0IE1hbmFnZW1lbnQg
Y2VydGlmaWNhdGUNClRyYWluaW5nIHdpbGwgYmUgDQogIGRvbmUgYXQgdGhlIEdsb2JhbCBL
aW5nIFByb2plY3QgTWFuYWdlbWVudCBDZW50ZXJzIChOYWlyb2JpIEtlbnlhLCBNb21iYXNh
IA0KICBLZW55YSwgS2lnYWxpIFJ3YW5kYSwgRHViYWksIExhZ29zIE5pZ2VyaWEgYW5kIE1v
cmUgDQogIG90aGVycykNCkNvdXJzZSBkdXJhdGlvbiANCiAgaXMgZmxleGlibGUgYW5kIHRo
ZSBjb250ZW50cyBjYW4gYmUgbW9kaWZpZWQgdG8gZml0IGFueSBudW1iZXIgb2YgDQogIGRh
eXMuwqDCoMKgwqDCoMKgDQpQYXltZW50IHNob3VsZCANCiAgYmUgZG9uZSB0d28gd2Vla3Mg
YmVmb3JlIGNvbW1lbmNlbWVudCBvZiB0aGUgdHJhaW5pbmcsIHRvIHRoZSBHbG9iYWwgS2lu
ZyANCiAgUHJvamVjdCBNYW5hZ2VtZW50IGFjY291bnQsIHNvIGFzIHRvIGVuYWJsZSB1cyB0
byBwcmVwYXJlIGJldHRlciBmb3IgDQogIHlvdS4NCsK3wqDCoMKgwqDCoMKgwqDCoCANClRo
ZSBjb3Vyc2UgZmVlIA0KZm9yIG9uc2l0ZSB0cmFpbmluZyBpbmNsdWRlcyBmYWNpbGl0YXRp
b24gdHJhaW5pbmcgbWF0ZXJpYWxzLCAyIGNvZmZlZSBicmVha3MsIGEgDQpidWZmZXQgbHVu
Y2gsIGFuZCBhIENlcnRpZmljYXRlIG9mIHN1Y2Nlc3NmdWwgY29tcGxldGlvbiBvZiBUcmFp
bmluZy4gDQpQYXJ0aWNpcGFudHMgd2lsbCBiZSByZXNwb25zaWJsZSBmb3IgdGhlaXIgb3du
IHRyYXZlbCBleHBlbnNlcyBhbmQgYXJyYW5nZW1lbnRzLCANCmFpcnBvcnQgdHJhbnNmZXJz
LCB2aXNhIGFwcGxpY2F0aW9uIGRpbm5lcnMsIGhlYWx0aC9hY2NpZGVudCBpbnN1cmFuY2Us
IGFuZCANCm90aGVyIHBlcnNvbmFsIGV4cGVuc2VzLg0KwrfCoMKgwqDCoMKgwqDCoMKgIA0K
wqDCoMKgwqDCoMKgwqBBY2NvbW1vZGF0aW9uLCANCnBpY2t1cCwgZnJlaWdodCBib29raW5n
LCBhbmQgVmlzYSBwcm9jZXNzaW5nIGFycmFuZ2VtZW50LCBhcmUgZG9uZSBvbiByZXF1ZXN0
LCANCmF0IGRpc2NvdW50ZWQgcHJpY2VzLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCANCg0KwrfCoMKgwqDCoMKgwqDCoMKgIA0KwqDCoFRhYmxldCBhbmQg
TGFwdG9wcyBhcmUgDQpwcm92aWRlZCB0byBwYXJ0aWNpcGFudHMgb24gcmVxdWVzdCBhcyBh
biBhZGQtb24gY29zdCB0byB0aGUgdHJhaW5pbmcgDQpmZWUuDQrCt8KgwqDCoMKgwqDCoMKg
wqAgDQrCoMKgT25lLXllYXLCoGZyZWUgDQpDb25zdWx0YXRpb24gYW5kIENvYWNoaW5nIHBy
b3ZpZGVkIGFmdGVyIHRoZSBjb3Vyc2UuDQrCt8KgwqDCoMKgwqDCoMKgwqAgDQrCoFJlZ2lz
dGVyIA0KYXMgYSBncm91cCBvZiBtb3JlIHRoYW4gdHdvIGFuZCBlbmpveSBhIGRpc2NvdW50
IG9mICgxMCUgdG8gDQo1MCUpDQrCt8KgwqDCoMKgwqDCoMKgwqAgDQrCt8KgwqDCoCBQYXlt
ZW50IHNob3VsZCBiZSBkb25lIA0KYmVmb3JlIGNvbW1lbmNlIG9mIHRoZSB0cmFpbmluZyBv
ciBhcyBhZ3JlZWQgYnkgdGhlIHBhcnRpZXMsIHRvIHRoZSBHTE9CQUwgS0lORyANClBST0pF
Q1QgTUFOQUdFTUVOVCBhY2NvdW50LCBzbyBhcyB0byBlbmFibGUgdXMgdG8gcHJlcGFyZSBi
ZXR0ZXIgZm9yIA0KeW91Lg0KwrfCoMKgwqDCoMKgwqDCoMKgIA0KwqBGb3IgYW55IGlucXVp
cnkgDQp0bzrCoMKgdHJhaW5pbmdAZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50Lm9yZyDC
oG9yIMKgKzI1NCAxMTQgODMwIDg4OcKgIMKgDQrCt8KgwqDCoMKgwqDCoMKgwqAgDQrCoFdl
YnNpdGU6wqANCjxodHRwOi8vdHJhY2tpbmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50
LmNvbS90cmFja2luZy9jbGljaz9kPUxOeDRybHRnRHVNMkpXWEYwR1B3ak9FZFZhZ0ZWZnZD
ekZJMHhKbnp5U3hzampkN2s1b3ZBOHlwN3ZZQzRsbE92em12eUhyZ0l3U19KOTVKRzR0QUNt
TEJxZTBSZXBsSDZjYzJ0azVlaU1vamVXby1Md1I1VElvQW1KOS1TY2F4akEyPg0Kd3d3LiAN
Cmdsb2JhbGtpbmdwcm9qZWN0bWFuYWdlbWVudC5vcmfCoA0KwqANCkluZGljYXRpdmUgDQpC
dWRnZXQNClRoZSANCnJlZ2lzdHJhdGlvbiBjb3N0IGlzIGluZGljYXRlZCBpbiBldmVyeSBj
b3Vyc2UgZm9yIG9ubGluZSBhbmQgb25zaXRlIHRyYWluaW5ncyANCmZpbmQgdGhlIGdyb3Vw
IHJhdGUgZGlzY291bnQgYmVsb3c6DQpHcm91cCANCiAgICAgIFNpemUNCkRpc2NvdW50IA0K
ICAgICAgUmF0ZSBmb3IgR3JvdXANCjItNw0KwqDCoMKgIA0KICAgICAgMjAlDQrCoDgtMjEN
CsKgwqDCoCANCiAgICAgIDI1JQ0KMjItMzENCsKgwqDCoCANCiAgICAgIDMwJQ0KMzItNDEN
CsKgwqDCoCANCiAgICAgIDM1JQ0KNDItNTENCsKgwqDCoCANCiAgICAgIDQwJQ0KNTI+QWJv
dmUNCsKgwqDCoCANCiAgICAgIDUwJQ0KwqANCsKgDQrCoA0KSW1wb3J0YW50wqAgR0tQTSBM
aW5rczrCoMKgIA0KDQo8aHR0cDovL3RyYWNraW5nLmdsb2JhbGtpbmdwcm9qZWN0bWFuYWdl
bWVudC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1OeTBIUU9fREpteFFqMDlLb0k1UUw0R0lmelBi
dGs1QmowMUdsWlFJS2tncXF5N1FLQVZCazBMUndmMjAxMWNXQVM2Z0xHd2VCbTNMTzV1MHRV
aUpNdXREWTk5VktJdmxBNmZETUZXUjBQdUtxUWhLUUF0SEV6dWxYeTYzcXVfYlU3a2JlcmhI
aXBTblp2TkoySjkzVzE0bi03NmdUaTFaQzdWYlViWGZGaWNDMD4NCkFsbCBDb3Vyc2VzDQpQ
cm9qZWN0IA0KTWFuYWdlbWVudCBUcmFpbmluZ3MNCg0KPGh0dHA6Ly90cmFja2luZy5nbG9i
YWxraW5ncHJvamVjdG1hbmFnZW1lbnQuY29tL3RyYWNraW5nL2NsaWNrP2Q9TnkwSFFPX0RK
bXhRajA5S29JNVFMNEdJZnpQYnRrNUJqMDFHbFpRSUtranljSzluM2kwdGdBS0NMMzRBWGNJ
VmlIUzR0cV8tVXNBSEpqRlZrUWoxaFdmM0lyM1pFYm1URGh1c1NPRkJMZGxhajBVaUhGd2hx
SVB2MGxIOTlPaFFfM3NiRndqRjRERHBOcTlsQkw0WHEySjlSejFHcDRxRHBJRzFTMTYyR3I3
dDA+DQpSZXNlYXJjaCB0cmFpbmluZyBDb3Vyc2VzDQoNCjxodHRwOi8vdHJhY2tpbmcuZ2xv
YmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNvbS90cmFja2luZy9jbGljaz9kPU55MEhRT19E
Sm14UWowOUtvSTVRTDRHSWZ6UGJ0azVCajAxR2xaUUlLa2p5Y0s5bjNpMHRnQUtDTDM0QVhj
SVZtZ2MtaXNmOFlnUWY5LTFhVGQwSGNhbWxsVlNWNlRXQXBwNVljY1cxNDBtT200NHVCY0Jo
cENNWjZuS1FxV3VtTVhraWlXSVJhVzN0M2stWWNiSlNDWnhWTnJMSHppOVczMDQtbWVmYXRW
NGgwPg0KTGVhZGVyc2hpcCBUcmFpbmluZyBDb3Vyc2VzIMKgDQoNCjxodHRwOi8vdHJhY2tp
bmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNvbS90cmFja2luZy9jbGljaz9kPXdv
MmFYLV9oNTJlRHVFdDE5NHhZTzUyaVhSNTI2V0JIWE5jb2stZWpESlhmc1FyT1p5WHUwX0tE
RFFJTGtfcmh2QU1FQlZSREcxMU0tNWYzR2NlNXZidGlwX1RuR0pYZHJuekpMZGFsSUVuaHdh
X2R3NFUxRWQwc1phaEU2ZEllOUgyYkNjNzFYeVNGaW1wSGNueElEaXJ0Z0dIMUZTME9LOGFJ
c2hSVm82NFhDWElUNTB5OXdQNDVabUNEYXFhVEdRMj4NCkRvd25sb2FkIG91ciBDYWxlbmRh
cg0KWW91cnMgDQpTaW5jZXJlbHkswqAgwqDCoMKgDQrCoA0KVmlyZ2luaWEgDQpXYW1haXRo
YSANClByb2plY3QgDQpNYW5hZ2VtZW50IEV4cGVydCBhbmQgUE1QIGNlcnRpZmllZA0KDQo8
aHR0cDovL3RyYWNraW5nLmdsb2JhbGtpbmdwcm9qZWN0bWFuYWdlbWVudC5jb20vdHJhY2tp
bmcvY2xpY2s/ZD1UNWg3SjVPbExIZ1JQNU9vcW1VMUhfRWtnN1dub1EtUGZkZmM1bkZZaG5H
SnRYbGNDNUpxb1ViYmFxUHpXUGZSVE5sMjcxUGo4dlBhVzAxaTgzS2NoQjNJLXBvc0ZWaFho
MXJKamhaSzU5OURtbF9wMlkzNktJcTVYMXN3ZVJXaGQ5eEJXNnZLTzlVSDdhTGRVOWFBcVE0
Q2h2NlczQW1BeFZneTl1TlVOODEtMD4NCkdsb2JhbCBLaW5nIFByb2plY3QgTWFuYWdlbWVu
dCANClRlbGU6IA0KKzI1NDExNDgzMDg4OQ0KRW1haWwgDQpBZGRyZXNzOiB0cmFpbmluZ0Bn
bG9iYWxraW5ncHJvamVjdG1hbmFnZW1lbnQub3JnwqAgDQpUcmFuc25hdGlvbmFsIA0KUGxh
emEgM3JkIEZsb29yIE5haXJvYmksIEtlbnlhIMKgwqDCoA0KwqANCjxodHRwOi8vdHJhY2tp
bmcuZ2xvYmFsa2luZ3Byb2plY3RtYW5hZ2VtZW50LmNvbS90cmFja2luZy91bnN1YnNjcmli
ZT9kPTVoQllqckIzX2RaVzJaR1BlTmxWVmwzbWwtSjB4aEphdGExNzluZlhibzlJMFE4Zjh4
VHprVU9uWTFTY1dzSzBhMGlKN09CN0dHTjIyOVNWbU54SXRyMkdRVHd6c01XTUFQTmdSV1Vl
azlrbDA+DQpVTlNVQlNDUklCRQ==

--=-eZCfImvepwr1NfeuOfwVfH+T/g9yx/gn23WKzQ==
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Ty=
pe>
<META name=3DGENERATOR content=3D"MSHTML 6.00.6000.16546"></HEAD>
<BODY>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c"><?xml:n=
amespace=20
prefix =3D "o" ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p>&nbsp;</o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkhuCo_RmN-jcOt3bOSs7lUph=
3MrBb0xorY-ijuMqWqeS9Ns7OxzxCxlyvbXadR19vAfafIrK-8Wkbo5eVK9n-I9S1uJOM1=
8ZMjpsEOEz7znnap8PukO8tfECZqaiiixycXp0"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><FONT color=3D#0000ff>P=
roject=20
Monitoring and Evaluation with Data Management and Analysis Course Aug=
ust15 2022=20
to August 26 2022 Mombasa Kenya</FONT></SPAN></A><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c"><o:p></=
o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c"><o:p>&n=
bsp;</o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c">Venue</=
SPAN><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: black; mso-theme=
color: text1">:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>Onsite Mombasa or Nairobi Ken=
ya or online=20
platform</SPAN><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c">.<o:p><=
/o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c"><o:p>&n=
bsp;</o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c">Registr=
ation:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN></SPAN><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DoMvADaRTOIAmFuhyK0ftFs-V9a3nm2Bzn5I59VdgnV3EJtCPNPehFHvSGr3vc5nYQ=
gBSK8Y94RuQCtyp7eCWfgI7hCrBkAN57IAkXs2dcEkF9SIxhx9bGMUHtf8YzNh3I0zyGUP=
l3lIKhvoHTnAZOdXUtwi30ZQstO85aPcJ-WBH77d4THLYDjD3T0ntWasAlg2"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><FONT color=3D#0000ff>U=
se this link=20
to register</FONT></SPAN></A><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c"><o:p></=
o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c"><o:p>&n=
bsp;</o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN style=3D"FONT-SIZE: 14pt; FONT-WEIGHT:=
 normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DFvm3u06RbVn7m8FcN7DuPsmR11UiukHaQ-0QYwOavdilXiANo1yYbL6HurLFW1gsW=
NOqEYvX0tbLNYaE-JM2pU8Bmmjb4oMWmOtxpwWnDlBnH3MlgDqmQIEIrve8U26HQmbZ3I0=
H3LzjN2ZLhKl04-mj2TtfjVfmDfu3yyfF_DFpr1gX8uHxEBUqY8A02zWNCc8MW_QE5p5ei=
FvLZINSVBqlBT6ZB9QZP_HOG-_UAn0I2EuK67gu_E7gakbjl0rNbsVcY3Mo03vF2tzrNgu=
ZSMc1"><FONT=20
color=3D#0000ff>Download Admission Form:<o:p></o:p></FONT></A></SPAN><=
/H4>
<H4 style=3D"MARGIN: 0in"><SPAN style=3D"FONT-SIZE: 14pt; FONT-WEIGHT:=
 normal"><SPAN=20
style=3D"COLOR: #03b97c"><o:p>&nbsp;</o:p></SPAN></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3Dwo2aX-_h52eDuEt194xYO52iXR526WBHXNcok-ejDJXfsQrOZyXu0_KDDQILk_rhv=
AMEBVRDG11M-5f3Gce5vbDA5tnbDJgkIiiECjvnBsdH4WDU_5vfHvTjctKM3cuceNYJWwh=
JgPZM5q-CAj3VMmuZ9NzSOyrQwWTRShZqyprcIOr1OBfU7ROv_2GesMCMQw2"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><FONT color=3D#0000ff>D=
ownload Our=20
Calendar:</FONT></SPAN></A><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c"><o:p></=
o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: #03b97c"><o:p>&n=
bsp;</o:p></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkgqqy7QKAVBk0LRwf2011cWA=
S6gLGweBm3LO5u0tUiJMhn45ld4y8TwI5V6q-RFad7w5ot1tOaEfwZEMYRbfbOgqZkY4Qd=
OgJeze0hy8rpNH1hwVZzLZ3aDZkKMthz69KWp0"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><FONT color=3D#0000ff>V=
iew all our=20
courses</FONT></SPAN></A><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><o:p></o:p></SPAN></SPA=
N></H4>
<H4 style=3D"MARGIN: 0in"><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><o:p><SPAN=20
style=3D"TEXT-DECORATION: none"><U><FONT=20
color=3D#0000ff>&nbsp;</FONT></U></SPAN></o:p></SPAN></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3Djzdoh1CTZ5m8avz2jGJ4bvotLAShCBh6jtREM_Wc7L0h3UPik2wcrCjwKBk1abdIQ=
iDT8iKtxpTac4HBwwuDeGcgi_OfXKDyN8jiby8EwWAK4oNCKcBaAiXhDsuUjZAbqQIvVQU=
-bgLe_uMMomwGwA_XQJsWxojgNrGAEH2F47c49u411dJR1vTQ5Rxxlh2OcQJZJLytxCw87=
18xcxw-CZEWT-e050l6EovrMcAQHgOnCFTBxmJmUwJpx5KpXJmKkgARJply0yOXdiLWctR=
b2aVsH19e38Ply3zd7RO-60tjbZysrygsaZPoUfriazhnEg2"><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><FONT color=3D#0000ff>R=
each us=20
through WhatsApp</FONT></SPAN></A><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><o:p></o:p></SPAN></SPA=
N></H4>
<H4 style=3D"MARGIN: 0in"><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><o:p><SPAN=20
style=3D"TEXT-DECORATION: none"><U><FONT=20
color=3D#0000ff>&nbsp;</FONT></U></SPAN></o:p></SPAN></SPAN></H4>
<H4 style=3D"MARGIN: 0in"><SPAN class=3DMsoHyperlink><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal"><U><FONT color=3D#0000f=
f>Reach us:=20
training@globalkingprojectmanagement.org / +254 114 830=20
889</FONT></U></SPAN></SPAN><A name=3D_Hlk106179249><SPAN=20
style=3D"FONT-SIZE: 14pt; FONT-WEIGHT: normal; COLOR: blue"><o:p></o:p=
></SPAN></A></H4><SPAN=20
style=3D"mso-bookmark: _Hlk106179249"></SPAN>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 15pt"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #222222; mso-fareast-font-family: "Times New Roman"'><o:p>&nbsp;</o:p=
></SPAN></P>
<H4 style=3D"MARGIN: 0in"><SPAN style=3D"FONT-SIZE: 14pt; COLOR: black=
">About the=20
course</SPAN><SPAN=20
style=3D"FONT-SIZE: 14pt; COLOR: #555555"><o:p></o:p></SPAN></H4>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>This=20
is a comprehensive 10 days M&amp;E course that covers the principles a=
nd=20
practices for results-based monitoring and evaluation for the entire p=
roject=20
life cycle. This course equips participants with skills in setting up =
and=20
implementing results-based monitoring and evaluation systems including=
 M&amp;E=20
data management, analysis, and reporting. The participants will benefi=
t from the=20
latest M&amp;E thinking and practices including the results and partic=
ipatory=20
approaches. This course is designed to enable the participants become =
experts in=20
monitoring and evaluating their development projects. The course cover=
s all the=20
key elements of a robust M&amp;E system coupled with a practical proje=
ct to=20
illustrate the M&amp;E concepts.&nbsp;</SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Target=20
Participants</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>This=20
course is designed for researchers, project staff, development practit=
ioners,=20
managers and decision makers who are responsible for project, program =
or=20
organization-level M&amp;E. The course aims to enhance the skills of=20
professionals who need to research, supervise, manage, plan, implement=
, monitor=20
and evaluate development projects.</SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Course=20
duration</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>10=20
days</SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Course=20
objectives</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
lop project=20
  results levels<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Desi=
gn a project=20
  using logical framework<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
lop=20
  indicators and targets for each result level<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Trac=
k=20
  performance indicators over the life of the project<o:p></o:p></SPAN=
></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uation a=20
  project against the set results<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
lop and=20
  implement M&amp;E systems<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
lop a=20
  comprehensive monitoring and evaluation plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Use =
data=20
  analysis software (Stata/SPSS/R)<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Coll=
ect data=20
  using mobile data collection tools<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Carr=
yout impact=20
  evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
14 level1 lfo1; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Use =
GIS to=20
  analyze and share project data<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Course=20
Outline</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Introduction=20
to Results Based Project Management</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Fund=
amentals of=20
  Results Based Management<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Why =
is RBM=20
  important?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Resu=
lts based=20
  management vs traditional projects management<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>RBM =
Lifecycle=20
  (seven phases)<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
15 level1 lfo2; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Area=
s of focus=20
  of RBM<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Fundamentals=20
of Monitoring and Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Defi=
nition of=20
  Monitoring and Evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Why =
Monitoring=20
  and Evaluation is important<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Key =
principles=20
  and concepts in M&amp;E<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E in=20
  project lifecycle<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
4 level1 lfo3; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Part=
icipatory=20
  M&amp;E<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Project=20
Analysis</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
10 level1 lfo4; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Situ=
ation=20
  Analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
10 level1 lfo4; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Need=
s=20
  Assessment<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
10 level1 lfo4; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Stra=
tegy=20
  Analysis<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Design=20
of Results in Monitoring and Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
19 level1 lfo5; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Resu=
lts chain=20
  approaches: Impact, outcomes, outputs and activities<o:p></o:p></SPA=
N></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
19 level1 lfo5; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Resu=
lts=20
  framework<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
19 level1 lfo5; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E causal=20
  pathway<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
19 level1 lfo5; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Prin=
ciples of=20
  planning, monitoring and evaluating for results<o:p></o:p></SPAN></L=
I></UL>
<P class=3DMsoNormal=20
style=3D"TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Indicators</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-list: l0 level1 lfo6; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Indi=
cators=20
  definition<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-list: l0 level1 lfo6; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Indi=
cator=20
  metrics<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-list: l0 level1 lfo6; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Link=
ing=20
  indicators to results<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-list: l0 level1 lfo6; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Indi=
cator=20
  matrix<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; TEXT-ALIGN: justify; MARGIN: 0in; LINE-HEIGHT=
: normal; mso-list: l0 level1 lfo6; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Trac=
king of=20
  indicators<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Logical=20
Framework Approach</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>LFA =
&#8211; Analysis=20
  and Planning phase<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Desi=
gn of=20
  logframe<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Risk=
 rating in=20
  logframe<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Hori=
zontal and=20
  vertical logic in logframe<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Usin=
g logframe=20
  to create schedules: Activity and Budget schedules<o:p></o:p></SPAN>=
</LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
16 level1 lfo7; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Usin=
g logframe=20
  as a project management tool<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Theory=20
of Change</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
9 level1 lfo8; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Over=
view of=20
  theory of change<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
9 level1 lfo8; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Deve=
loping=20
  theory of change<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
9 level1 lfo8; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Theo=
ry of Change=20
  vs Log Frame<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
9 level1 lfo8; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Case=
 study:=20
  Theory of change<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Systems</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
3 level1 lfo9; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>What=
 is an=20
  M&amp;E System?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
3 level1 lfo9; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Elem=
ents of=20
  M&amp;E System<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
3 level1 lfo9; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Step=
s for=20
  developing Results based M&amp;E System<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Planning</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
11 level1 lfo10; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Impo=
rtance of an=20
  M&amp;E Plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
11 level1 lfo10; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Docu=
menting=20
  M&amp;E System in the M&amp;E Plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
11 level1 lfo10; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Comp=
onents of an=20
  M&amp;E Plan-Monitoring, Evaluation, Data management,=20
  Reporting<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
11 level1 lfo10; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Usin=
g M&amp;E=20
  Plan to implement M&amp;E in a Project<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
11 level1 lfo10; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E plan vs=20
  Performance Management Plan (PMP)<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Base=20
Survey in Results based M&amp;E</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
13 level1 lfo11; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Impo=
rtance of=20
  baseline studies<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
13 level1 lfo11; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Proc=
ess of=20
  conducting baseline studies<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
13 level1 lfo11; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Base=
line study=20
  vs evaluation<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Project=20
Performance Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
22 level1 lfo12; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Proc=
ess and=20
  progress evaluations<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
22 level1 lfo12; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uation=20
  research design<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
22 level1 lfo12; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uation=20
  questions<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
22 level1 lfo12; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Eval=
uation=20
  report Dissemination<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Data Management</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
17 level1 lfo13; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Diff=
erent=20
  sources of M&amp;E data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
17 level1 lfo13; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Qual=
itative data=20
  collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
17 level1 lfo13; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Quan=
titative=20
  data collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
17 level1 lfo13; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Part=
icipatory=20
  methods of data collection<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
17 level1 lfo13; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 Quality=20
  Assessment<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>M&amp;E=20
Results Use and Dissemination</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
23 level1 lfo14; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Stak=
eholder&rsquo;s=20
  information needs<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
23 level1 lfo14; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Use =
of M&amp;E=20
  results to improve and strengthen projects<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
23 level1 lfo14; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Use =
of M&amp;E=20
  Lessons learnt and Best Practices<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
23 level1 lfo14; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Orga=
nization=20
  knowledge champions<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
23 level1 lfo14; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E=20
  reporting format<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
23 level1 lfo14; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E results=20
  communication strategies<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Gender=20
Perspective in M&amp;E</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
18 level1 lfo15; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Impo=
rtance of=20
  gender in M&amp;E<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
18 level1 lfo15; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Inte=
grating=20
  gender into program logic<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
18 level1 lfo15; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Sett=
ing gender=20
  sensitive indicators<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
18 level1 lfo15; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Coll=
ecting=20
  gender disaggregated data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
18 level1 lfo15; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Anal=
yzing=20
  M&amp;E data from a gender perspective<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
18 level1 lfo15; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Appr=
aisal of=20
  projects from a gender perspective<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Data=20
Collection Tools and Techniques</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Sour=
ces of=20
  M&amp;E data &#8211;primary and secondary<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Samp=
ling during=20
  data collection<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Qual=
itative data=20
  collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Quan=
titative=20
  data collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Part=
icipatory=20
  data collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
6 level1 lfo16; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  data triangulation<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Data=20
Quality</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>What=
 is data=20
  quality?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Why =
data=20
  quality?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 quality=20
  standards<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 flow and=20
  data quality<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 Quality=20
  Assessments<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
2 level1 lfo17; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>M&am=
p;E system=20
  design for data quality<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>ICT=20
in Monitoring and Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
8 level1 lfo18; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Mobi=
le based=20
  data collection using ODK<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
8 level1 lfo18; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Data=
=20
  visualization - info graphics and dashboards<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
8 level1 lfo18; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Use =
of ICT tools=20
  for Real-time monitoring and evaluation<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Qualitative=20
Data Analysis</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Prin=
ciples of=20
  qualitative data analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 preparation=20
  for qualitative analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Link=
ing and=20
  integrating multiple data sets in different forms<o:p></o:p></SPAN><=
/LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Them=
atic=20
  analysis for qualitative data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Cont=
ent analysis=20
  for qualitative data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
1 level1 lfo19; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Mani=
pulation and=20
  analysis of data using NVivo<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Quantitative=20
Data Analysis &#8211; (Using SPSS/Stata)</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
21 level1 lfo20; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  statistical concepts<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
21 level1 lfo20; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Crea=
ting=20
  variables and data entry<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
21 level1 lfo20; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Data=
=20
  reconstruction<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
21 level1 lfo20; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Vari=
ables=20
  manipulation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
21 level1 lfo20; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Desc=
riptive=20
  statistics<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
21 level1 lfo20; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Unde=
rstanding=20
  data weighting<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
21 level1 lfo20; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Infe=
rential=20
  statistics: hypothesis testing, T-test, ANOVA, regression=20
  analysis<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>Impact=20
Assessment</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
20 level1 lfo21; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  impact evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
20 level1 lfo21; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Attr=
ibution in=20
  impact evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
20 level1 lfo21; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Esti=
mation of=20
  counterfactual<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
20 level1 lfo21; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Impa=
ct=20
  evaluation methods: Double difference, Propensity score=20
  matching<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: 16.9pt"><B><SP=
AN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'>GIS=20
in M&amp;E</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
12 level1 lfo22; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Intr=
oduction to=20
  GIS in M&amp;E<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
12 level1 lfo22; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>GIS =
analysis and=20
  mapping techniques<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
12 level1 lfo22; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Data=
 preparation=20
  for geospatial analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
12 level1 lfo22; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Geos=
patial=20
  analysis using GIS software (QGIS)<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.5in; LINE-HEIGHT: =
normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>General=20
Notes</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 #555555; LINE-HEIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 0.5in; TEXT-INDENT: -0.25in; mso-list: l7=
 level1 lfo23; tab-stops: list .5in"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 14.0pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"FONT-SIZE: 14pt; COLOR: black">All=
 our courses=20
can be Tailor-made to participants needs<o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0in" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>The =
participant=20
  must be conversant with English<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>&nbs=
p;Presentations=20
  are well guided, practical exercises, web-based tutorials, and group=
 work. Our=20
  facilitators are experts&nbsp;with more than 10years of=20
  experience<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>&nbs=
p;Upon=20
  completion of training, the participant will be issued with a Global=
 King=20
  Project Management certificate<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Trai=
ning will be=20
  done at the Global King Project Management Centers (Nairobi Kenya, M=
ombasa=20
  Kenya, Kigali Rwanda, Dubai, Lagos Nigeria and More=20
  others)<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Cour=
se duration=20
  is flexible and the contents can be modified to fit any number of=20
  days.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0in; LINE-HEIGHT: normal; mso-list: l=
7 level1 lfo23; tab-stops: list .5in"><SPAN=20
  style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif'>Paym=
ent should=20
  be done two weeks before commencement of the training, to the Global=
 King=20
  Project Management account, so as to enable us to prepare better for=
=20
  you.<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 49.5pt; TEXT-INDENT: -0.25in; mso-list: l=
5 level1 lfo24; tab-stops: list 49.5pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 14.0pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"FONT-SIZE: 14pt; COLOR: black">The=
 course fee=20
for onsite training includes facilitation training materials, 2 coffee=
 breaks, a=20
buffet lunch, and a Certificate of successful completion of Training.=20
Participants will be responsible for their own travel expenses and arr=
angements,=20
airport transfers, visa application dinners, health/accident insurance=
, and=20
other personal expenses.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 49.5pt; TEXT-INDENT: -0.25in; mso-list: l=
5 level1 lfo24; tab-stops: list 49.5pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 14.0pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 14pt; COLOR: black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;Accommodation,=20
pickup, freight booking, and Visa processing arrangement, are done on =
request,=20
at discounted prices.<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=20
</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 49.5pt; TEXT-INDENT: -0.25in; mso-list: l=
5 level1 lfo24; tab-stops: list 49.5pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 14.0pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 14pt; COLOR: black">&nbsp;&nbsp;Tablet and Laptops=
 are=20
provided to participants on request as an add-on cost to the training=20
fee.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 49.5pt; TEXT-INDENT: -0.25in; mso-list: l=
5 level1 lfo24; tab-stops: list 49.5pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 14.0pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 14pt; COLOR: black">&nbsp;&nbsp;One-year&nbsp;free=
=20
Consultation and Coaching provided after the course.<o:p></o:p></SPAN>=
</P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 49.5pt; TEXT-INDENT: -0.25in; mso-list: l=
5 level1 lfo24; tab-stops: list 49.5pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 14.0pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"FONT-SIZE: 14pt; COLOR: black">&nb=
sp;Register=20
as a group of more than two and enjoy a discount of (10% to=20
50%)<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 49.5pt; TEXT-INDENT: -0.25in; mso-list: l=
5 level1 lfo24; tab-stops: list 49.5pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 14.0pt"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 14pt; COLOR: black">&middot;&nbsp;&nbsp;&nbsp; Pay=
ment should be done=20
before commence of the training or as agreed by the parties, to the GL=
OBAL KING=20
PROJECT MANAGEMENT account, so as to enable us to prepare better for=20
you.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 49.5pt; TEXT-INDENT: -0.25in; mso-list: l=
5 level1 lfo24; tab-stops: list 49.5pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; COLOR: black; mso-farea=
st-font-family: Symbol; mso-bidi-font-family: Symbol; mso-bidi-font-si=
ze: 14.0pt; mso-bidi-font-weight: bold"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN style=3D"FONT-SIZE: 14pt; COLOR: black"><SP=
AN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><B>For any inquiry=20
to:&nbsp;</B></SPAN><A><B><SPAN=20
style=3D"FONT-SIZE: 14pt; TEXT-DECORATION: none; COLOR: black; text-un=
derline: none">&nbsp;training@globalkingprojectmanagement.org</SPAN></=
B></A><B><SPAN=20
style=3D"FONT-SIZE: 14pt; COLOR: black"> &nbsp;or <SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>+254 114 830 889<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>&nbsp;<o:p></o:p></SPAN></B>=
</P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0in 0in 0in 49.5pt; TEXT-INDENT: -0.25in; mso-list: l=
5 level1 lfo24; tab-stops: list 49.5pt"><SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D"FONT-SIZE: 10pt; TEXT-DECORATION: none; FONT-FAMILY: Symbol; =
COLOR: black; mso-fareast-font-family: Symbol; mso-bidi-font-family: S=
ymbol; text-underline: none; mso-bidi-font-size: 14.0pt; mso-bidi-font=
-weight: bold"><SPAN=20
style=3D"mso-list: Ignore"><U>&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></U></SPAN></SPAN></SPAN><B><SPAN=20
style=3D"FONT-SIZE: 14pt; COLOR: black">&nbsp;Website:&nbsp;</SPAN></B=
><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DLNx4rltgDuM2JWXF0GPwjOEdVagFVfvCzFI0xJnzySxsjjd7k5ovA8yp7vYC4llOv=
zmvyHrgIwS_J95JG4tACmLBqe0ReplH6cc2tk5eiMojeWo-LwR5TIoAmJ9-ScaxjA2" ta=
rget=3D_blank><B><SPAN=20
style=3D"FONT-SIZE: 14pt; COLOR: black">www.=20
globalkingprojectmanagement.org&nbsp;</SPAN></B></A><SPAN=20
class=3DMsoHyperlink><B><SPAN=20
style=3D"FONT-SIZE: 14pt; TEXT-DECORATION: none; COLOR: black; text-un=
derline: none"><o:p></o:p></SPAN></B></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>Indicative=20
Budget<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'>The=20
registration cost is indicated in every course for online and onsite t=
rainings=20
find the group rate discount below:<B><o:p></o:p></B></SPAN></P>
<TABLE class=3DMsoTableGrid=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 48=
1.5pt; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; BORDER-L=
EFT: medium none; MARGIN: auto auto auto -13.75pt; mso-border-alt: sol=
id windowtext .5pt; mso-yfti-tbllook: 1184; mso-padding-alt: 0in 5.4pt=
 0in 5.4pt"=20
cellSpacing=3D0 cellPadding=3D0 width=3D642 border=3D1>
  <TBODY>
  <TR style=3D"mso-yfti-irow: 0; mso-yfti-firstrow: yes">
    <TD=20
    style=3D"BORDER-TOP: windowtext 1pt solid; BORDER-RIGHT: windowtex=
t 1pt solid; WIDTH: 2in; BORDER-BOTTOM: windowtext 1pt solid; PADDING-=
BOTTOM: 0in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: windo=
wtext 1pt solid; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; =
mso-border-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D192>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<B><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'>Group=20
      Size<o:p></o:p></SPAN></B></P></TD>
    <TD=20
    style=3D"BORDER-TOP: windowtext 1pt solid; BORDER-RIGHT: windowtex=
t 1pt solid; WIDTH: 337.5pt; BORDER-BOTTOM: windowtext 1pt solid; PADD=
ING-BOTTOM: 0in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: #=
f0f0f0; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-borde=
r-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5=
pt"=20
    vAlign=3Dtop width=3D450>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<B><SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'>Discount=20
      Rate for Group<o:p></o:p></SPAN></B></P></TD></TR>
  <TR style=3D"mso-yfti-irow: 1">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 2in; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0in; =
PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: windowtext 1pt sol=
id; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-al=
t: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D192>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'>2-7<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 337.5pt; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0=
in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: #f0f0f0; PADDI=
NG-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid =
windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-borde=
r-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D450>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'><SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;=20
      </SPAN>20%<o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"mso-yfti-irow: 2">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 2in; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0in; =
PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: windowtext 1pt sol=
id; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-al=
t: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D192>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'><SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;</SPAN>8-21<o:p></o:p></SPAN><=
/P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 337.5pt; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0=
in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: #f0f0f0; PADDI=
NG-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid =
windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-borde=
r-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D450>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'><SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;=20
      </SPAN>25%<o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"mso-yfti-irow: 3">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 2in; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0in; =
PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: windowtext 1pt sol=
id; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-al=
t: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D192>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'>22-31<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 337.5pt; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0=
in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: #f0f0f0; PADDI=
NG-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid =
windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-borde=
r-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D450>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'><SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;=20
      </SPAN>30%<o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"mso-yfti-irow: 4">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 2in; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0in; =
PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: windowtext 1pt sol=
id; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-al=
t: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D192>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'>32-41<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 337.5pt; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0=
in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: #f0f0f0; PADDI=
NG-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid =
windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-borde=
r-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D450>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'><SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;=20
      </SPAN>35%<o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"HEIGHT: 3.5pt; mso-yfti-irow: 5">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 3.5pt; BORDER-RIGHT: windowt=
ext 1pt solid; WIDTH: 2in; BORDER-BOTTOM: windowtext 1pt solid; PADDIN=
G-BOTTOM: 0in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: win=
dowtext 1pt solid; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent=
; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid win=
dowtext .5pt"=20
    vAlign=3Dtop width=3D192>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'>42-51<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; HEIGHT: 3.5pt; BORDER-RIGHT: windowt=
ext 1pt solid; WIDTH: 337.5pt; BORDER-BOTTOM: windowtext 1pt solid; PA=
DDING-BOTTOM: 0in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT:=
 #f0f0f0; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-bor=
der-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext =
.5pt; mso-border-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D450>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'><SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;=20
      </SPAN>40%<o:p></o:p></SPAN></P></TD></TR>
  <TR style=3D"mso-yfti-irow: 6; mso-yfti-lastrow: yes">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 2in; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0in; =
PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: windowtext 1pt sol=
id; PADDING-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-al=
t: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D192>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'>52&gt;Above<o:p></o:p></SPAN></P></TD>
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: windowtext 1pt solid; =
WIDTH: 337.5pt; BORDER-BOTTOM: windowtext 1pt solid; PADDING-BOTTOM: 0=
in; PADDING-TOP: 0in; PADDING-LEFT: 5.4pt; BORDER-LEFT: #f0f0f0; PADDI=
NG-RIGHT: 5.4pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid =
windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-borde=
r-top-alt: solid windowtext .5pt"=20
    vAlign=3Dtop width=3D450>
      <P class=3DMsoNormal style=3D"MARGIN: 0in; LINE-HEIGHT: normal">=
<SPAN=20
      style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; =
COLOR: black'><SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;=20
      </SPAN>50%<o:p></o:p></SPAN></P></TD></TR></TBODY></TABLE>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; LINE-HEIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT: normal"><B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'>Important<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>GKPM Links:</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkgqqy7QKAVBk0LRwf2011cWA=
S6gLGweBm3LO5u0tUiJMutDY99VKIvlA6fDMFWR0PuKqQhKQAtHEzulXy63qu_bU7kberh=
HipSnZvNJ2J93W14n-76gTi1ZC7VbUbXfFicC0"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><FONT=20
color=3D#0000ff>All Courses</FONT></SPAN></A><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT: normal"><U><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 blue; mso-fareast-font-family: Calibri'>Project=20
Management Trainings<o:p></o:p></SPAN></U></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkjycK9n3i0tgAKCL34AXcIVi=
HS4tq_-UsAHJjFVkQj1hWf3Ir3ZEbmTDhusSOFBLdlaj0UiHFwhqIPv0lH99OhQ_3sbFwj=
F4DDpNq9lBL4Xq2J9Rz1Gp4qDpIG1S162Gr7t0"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><FONT=20
color=3D#0000ff>Research training Courses</FONT></SPAN></A><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DNy0HQO_DJmxQj09KoI5QL4GIfzPbtk5Bj01GlZQIKkjycK9n3i0tgAKCL34AXcIVm=
gc-isf8YgQf9-1aTd0HcamllVSV6TWApp5YccW140mOm44uBcBhpCMZ6nKQqWumMXkiiWI=
RaW3t3k-YcbJSCZxVNrLHzi9W304-mefatV4h0"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><FONT=20
color=3D#0000ff>Leadership Training Courses </FONT></SPAN></A><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3Dwo2aX-_h52eDuEt194xYO52iXR526WBHXNcok-ejDJXfsQrOZyXu0_KDDQILk_rhv=
AMEBVRDG11M-5f3Gce5vbtip_TnGJXdrnzJLdalIEnhwa_dw4U1Ed0sZahE6dIe9H2bCc7=
1XySFimpHcnxIDirtgGH1FS0OK8aIshRVo64XCXIT50y9wP45ZmCDaqaTGQ2"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><FONT=20
color=3D#0000ff>Download our Calendar</FONT></SPAN></A><U><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 blue; mso-fareast-font-family: Calibri'><o:p></o:p></SPAN></U></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Yours=20
Sincerely,<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN></SPAN><SPAN=
=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;</SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Virginia=20
Wamaitha <o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Project=20
Management Expert and PMP certified<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><A=20
href=3D"http://tracking.globalkingprojectmanagement.com/tracking/click=
?d=3DT5h7J5OlLHgRP5OoqmU1H_Ekg7WnoQ-Pfdfc5nFYhnGJtXlcC5JqoUbbaqPzWPfRT=
Nl271Pj8vPaW01i83KchB3I-posFVhXh1rJjhZK599Dml_p2Y36KIq5X1sweRWhd9xBW6v=
KO9UH7aLdU9aAqQ4Chv6W3AmAxVgy9uNUN81-0"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><FONT=20
color=3D#0000ff>Global King Project Management </FONT></SPAN></A><U><S=
PAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 blue; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN><=
/U></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Tele:=20
+254114830889<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Email=20
Address: training@globalkingprojectmanagement.org<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0in 0.45pt; LINE-HEIGHT:=
 normal"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'>Transnational=20
Plaza 3<SUP>rd</SUP> Floor Nairobi, Kenya </SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: Calibri'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;</SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; mso-fa=
reast-font-family: "Times New Roman"'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in"><SPAN=20
style=3D'FONT-SIZE: 14pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P></BODY></HTML>

<img src=3D"http://tracking.globalkingprojectmanagement.com/tracking/o=
pen?msgid=3DFik9OYrPP3UZu62Lkprfbw2&c=3D1536700066050578323" style=3D"=
width:1px;height:1px" alt=3D"" /><div style=3D"text-align:center; back=
ground-color:#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;f=
ont-family:sans-serif;"><a href=3D"http://tracking.globalkingprojectma=
nagement.com/tracking/unsubscribe?d=3D5hBYjrB3_dZW2ZGPeNlVVl3ml-J0xhJa=
ta179nfXbo9I0Q8f8xTzkUOnY1ScWsK0a0iJ7OB7GGN229SVmNxItr2GQTwzsMWMAPNgRW=
Uek9kl0" style=3D"text-align:center;text-decoration:none;color:#666;">=
UNSUBSCRIBE</a></div>
--=-eZCfImvepwr1NfeuOfwVfH+T/g9yx/gn23WKzQ==--
