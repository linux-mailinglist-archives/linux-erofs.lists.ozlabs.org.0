Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C934445AC
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Nov 2021 17:15:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HksLk3FcBz2y0C
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Nov 2021 03:15:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=fdc-k.or.ke header.i=@fdc-k.or.ke header.a=rsa-sha256 header.s=api header.b=XGhmVIur;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=Wrm6og9b;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Too many DNS
 lookups) smtp.mailfrom=fdc-k.or.ke (client-ip=176.31.7.123;
 helo=mail1123.elasticemail.info; envelope-from=workshops@fdc-k.or.ke;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=fdc-k.or.ke header.i=@fdc-k.or.ke header.a=rsa-sha256
 header.s=api header.b=XGhmVIur; 
 dkim=pass (1024-bit key;
 unprotected) header.d=elasticemail.com header.i=@elasticemail.com
 header.a=rsa-sha256 header.s=api header.b=Wrm6og9b; 
 dkim-atps=neutral
Received: from mail1123.elasticemail.info (mail1123.elasticemail.info
 [176.31.7.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HksLc6GzNz2xCB
 for <linux-erofs@lists.ozlabs.org>; Thu,  4 Nov 2021 03:15:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=fdc-k.or.ke; s=api; c=relaxed/simple;
 t=1635956092; h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
 bh=rpHeLJ32oZCwrvR08biQPTjQn9RroQONMD5DxiKt9ic=;
 b=XGhmVIurs5bC5aVOxkphweDMxC3O2PRBjcQ2ZMtdRdoftt+P9zcd0OPSFELtedrYSE/qxzNpKLx
 D5Ty6H1nqDnjE09ztPUFiynRSviqDSrEbnHkZElRvUtuiVBYYErqRcxD1+JWAKjyCFW2Kn2/rHhzZ
 Yb9QlkG9fwc+CXxHOII=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
 c=relaxed/simple; t=1635956092;
 h=from:date:subject:reply-to:to:list-unsubscribe;
 bh=rpHeLJ32oZCwrvR08biQPTjQn9RroQONMD5DxiKt9ic=;
 b=Wrm6og9bBChkdaLdOI144NFKjq6ryPGZPkUVIcUVU6JOAcXxTxkg+zg6J2rDQ9O0cwQhYoIynm/
 vhDCX8BtHVE4/0I3qIt+cPyAOreOzlMF1YH3uL5NcBZ/iMpqDoahd+AOOHTWmJjQW/1SFXht/uV3c
 OM6/pOszUW41/xSdrQ4=
From: Foscore Development Center <workshops@fdc-k.or.ke>
Date: Wed, 03 Nov 2021 16:14:52 +0000
Subject: Invitation to Monitoring and Evaluation for Food Security and
 Nutrition Course Workshop Dec 06 to Dec 17,2021
Message-Id: <4uf7adlccjhs.82Tz160CZjD0EHKSKtkLzg2@tracking.fdc-k.or.ke>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: 82Tz160CZjD0EHKSKtkLzg2
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=-eZCfXDDh5HSad+SkYO1/TAHq4S923tI/y3WKzQ=="
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
Reply-To: workshops@fdc-k.or.ke
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-eZCfXDDh5HSad+SkYO1/TAHq4S923tI/y3WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwOi8vdHJhY2tpbmcuZmRjLWsub3Iua2UvdHJhY2tpbmcvY2xpY2s/ZD1fdlh0
YXp0bmVuXzdMNDkwNzhRT1AwczdRTXo0VFlMcFVjUmRudVJqTEJURVJ3ajRRUjFJaVUwczYz
WnJpSlFiajhHWnVxaV9VaVlTRmwtX25SRExyT0U2dXlBd3J2QzJScWlaU1NDXzNUa2JXYjV2
d05fYzhCZkJiQjVwTVVaM3JDN1FVSlhxREdQeHdVVWFmdXRkQmZrQU1Od2pHNEFBZ1NMNE9G
Vk5OT3U2Y2tpRXhlWFBXcUk2QjZqX2FOaUQyWURLdHU3V0JJZk1TenA5Tk82Mk94MThXR2V0
UjZNT2VfUXZYYmoxMGdlbGR2cEFzdm1QMzQ3WkJRTnU2cjdVRXcyPg0KwqBNb25pdG9yaW5n
IGFuZCANCkV2YWx1YXRpb24gZm9yIEZvb2QgU2VjdXJpdHkgYW5kIE51dHJpdGlvbiBDb3Vy
c2UgV29ya3Nob3AgRGVjIDA2IHRvIERlYyANCjE3LDIwMjENCsKgDQrCoA0KwqANCg0KPGh0
dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9kPXNiYzREVE1rWkhj
Mm1xWXVobXR6Nk5XMTVRVmM5OVR6QTJLaUNzd0dCNFFxb2tDall1ckxZQWVIcUctMXhRaDFH
QzRDSjFmWm03ekZKeGVEWW92c1BMTTcwUXRsYzBJXzhtc0J1eFNnVlV0YWNmZ1pkTkFFN1FU
Yk8xSFpnQURSbDQweWlGbWk1b2RBZTkzclBLcERTdEl3NE4tUDRFU3kwMnplRm5TYzdzRTZl
WC12TU4tOUxaR2R2RFZaZFZLV0wwWVdWTVZmYVVVak1YS1c3Z0YzaGkzYk9xNjFiNEtUamRQ
a2ZVTHdWNFp1aW11TUExUjM4bEs2dHVWaHRleGsxVXZjMUtDWHFiWVZMcmtKMFhURmZVRDVm
NTZBM19SUG1NQWNyVVI1cmxITTA+DQpSZWdpc3RlciBvbnNpdGUgYXR0ZW5kYW5jZSANCndv
cmtzaG9wDQrCoA0KDQo8aHR0cDovL3RyYWNraW5nLmZkYy1rLm9yLmtlL3RyYWNraW5nL2Ns
aWNrP2Q9aGxBaDA3SURFNVRlSEp3aHZWeVpya2Q0VVlrcVViY1QxZWFUTGQ2aHJtWjYwTlFr
ODYzb0pzeWI2Nlg4WHVwa1MxMnV0RHVEU1pkeUtZaEhwSnZ6NWtzcDFIdFFPLUpUWUY1MFZn
OGs2NWZ4RWwzRmtFM3RmWno3QmlvbXo2NTNfaWZKUGwwclF2RFh4bEwycnVuSHB2YkhldTly
eGtqMnVIR2daMEtBbjFLWDFUTlA5Wjlpc0NFN0k3WGViNzFkX1BKOE5wVm1DeUR5Qk42MVVz
QWl3NDhNMHRsZlVyVTd4bGtQaTVvNFhXN3FMUGNGM2U1YUt6Szg4WU1uWDZoa0lMMEJFaldW
UGNBNnpKOG52YllUZk5hdGplR0RWNnpfTkYyd0xxWHNyd2kwaWJHR1VZRWNPTnZmV09YY1R6
d25EdzI+DQpSZWdpc3RlciBmb3Igb25saW5lIGF0dGVuZGFuY2UgDQpXb3Jrc2hvcA0KwqAN
Cg0KPGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9kPUhaSlNO
aVJsaEMzQVpTaEhMc241UFRQb1JGNTFCS1lWOTEzUjlaZEw3SzV4RW1mZFJsM1hhOURodmxi
RkdlNVhRUzg1dTFyUENCM3NHRnNVS3loanFReC00WWNwV3JPUVJrMGxDZG9XTUR2Q0NKSjhm
RVNlM3BLb3pRWk5yd3lfM2cyYWpQS0gzY0xNQ0tpSktkNlpSZW5fWkdncGp3bWc5Y3c2bUFR
aDdPMFBEcVF5N2Z3WFZHcE9VdnFkSnR4ZUpLbDhRckFLQWNXb2tHal8tOWlfcVRlVTdmcmRs
STM1SU95MkhqNXR0Y1VhVkNnUVlmdW1HMklpZlg4M0x2bXBvcDhiZmFBV3N3S2JGMEhoNFRy
RnNKb0k2clBWS2N6Mm8zaWxnamoxbHRidDA+DQpHcm91cCBSZWdpc3RyYXRpb24gSGVyZQ0K
wqANCg0KPGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9kPXNy
ZUJ3b0R6WWRnajNiT2FCQ1JCc1VqZkJsN0lOczhtNkc3ODgwRk85M2lQbTZZY2lvTVZpaGJH
dDVnOXd2cDdwd3ZwcG1TcmFCMGxlXzBTQVBVNXFvU1R5VVhhSTNzZ2FJbTRZcHBkUXpNcDEw
bzFGYWVnM3pDdlRTa1hNLVJqOXVENTg4bVFDLWdmOVNUTXRaWlo4V2xGOW5vYXJnNjVRUVhv
bWFveThjT1QwPg0KRG93bmxvYWQgUERGIENhbGVuZGFyIDIwMjEtMjAyMiANCldvcmtzaG9w
cw0KwqANCg0KPG1haWx0bzp0cmFpbmluZ0BmZGMtay5vcmc/c3ViamVjdD1SRTogSW5xdWly
aW5nIG9uPg0KU2VuZCB1cyANCkVtYWlsDQrCoA0KDQo8aHR0cDovL3RyYWNraW5nLmZkYy1r
Lm9yLmtlL3RyYWNraW5nL2NsaWNrP2Q9SXVEYjVmVDRmYXBHRXBLRGViS1o1ckg4OTI2Qkts
OUl4R2IxVy1tQzBoS1RzRjIwaklsbHItc0g5LXdWYi1EajZ5SWlpREh4NlhtanZkbC1WSmti
aG9GUnJUdDZBSFJySWNTTkVWNFVlZDBnSEktSkZqcmxRaTFCeHplZ2ExNTJPSHAwVTdPUnlk
RUFDaURKQkJfTkFPQTE+DQpDb250YWN0IA0KdXMNCsKgDQoNCjxodHRwOi8vdHJhY2tpbmcu
ZmRjLWsub3Iua2UvdHJhY2tpbmcvY2xpY2s/ZD1SQW55ZjhMWDJmQWhtZXVSUEpEbERDZld4
TGJXVWNNOWNSMjBaQTFObW1vY0xyZXdJWkYtdFFsRTlqV0FVRjFYLWRZYnk3MkNzYzQxMmZm
c1RNNzdRcWVVcEJyVXoyWVhoYXhtREhyNEZZWlRTRU91Zm1EQmthdVBoNGdXbUlIR3BfTEpr
Yk8zN3ZNb1BSbUg1cmFIcDlJMT4NCldoYXRhcHANCsKgDQrCoA0KVkVOVUU6IA0KSElMVE9O
IEhPVEVMLCBOQUlST0JJIEtFTllBDQrCoA0KwrfCoMKgwqDCoMKgwqDCoMKgIA0KT0ZGSUNJ
QUwgDQpFTUFJTCBBRERSRVNTOsKgdHJhaW5pbmdAZmRjLWsub3JnDQrCt8KgwqDCoMKgwqDC
oMKgwqAgDQpPZmZpY2UgDQpUZWxlcGhvbmU6ICsyNTQ3MTIyNjAwMzENCsK3wqDCoMKgwqDC
oMKgwqDCoCANCg0KPGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGlj
az9kPWJuWXRrVU5QaTNzR1F4ZFF4N18tSjg5NWVWQ09SbXFVcWk0WmtXa3NMaTUxNS1pdnFU
OFI0d3pJaHlzUloxbFkzLW1YNFY1RlhiWlpreC1MRWd6TjhLS1hKcEFRZnNKWUU2Q1NIU0Fj
RURiMDRoUU53bWpIU1FSeWdQazY5c3ZWcHU4bnpCQVBHYWdmSTVoOGlqU2dtQml6R0RHVmJp
X0xWa0tDT2VjWlJIQUgwPg0KT3VyIDIwMjEgLSAyMDIyIFByb2Zlc3Npb25hbCBTaG9ydCBU
cmFpbmluZyANCkNvdXJzZXMNCsK3wqDCoMKgwqDCoMKgwqDCoCANClJlZ2lzdGVyIA0KYXMg
YSBncm91cCBvZiA1IG9yIG1vcmUgcGFydGljaXBhbnRzIGFuZCBnZXQgMjAlIGRpc2NvdW50
IG9uIGNvdXJzZSBmZWUuIFNlbmQgdXMgDQplbWFpbCB0byB0cmFpbmluZ0BmZGMtay5vcmcg
b3IgY2FsbCArMjU0NzEyMjYwMDMxDQrCoA0KSW50cm9kdWN0aW9uDQpJbiANCm9yZGVyIHRv
IGFjaGlldmUgYSB3b3JsZCBmcmVlIG9mIGh1bmdlciBhbmQgbWFsbnV0cml0aW9uLCBpdCBp
cyB2aXRhbCB0byBwcm92aWRlIA0Kc3VzdGFpbmFibGUgc29sdXRpb25zIHRoYXQgcHJvdmlk
ZSB0aGUgbGFyZ2VzdCBpbXBhY3RzIG9uIGRldmVsb3BtZW50IG91dGNvbWVzLiANCk1vbml0
b3JpbmcgYW5kIEV2YWx1YXRpb24gdG9vbHMgYW5kIHRlY2huaXF1ZXMgcGxheXMgYSBrZXkg
cm9sZSBpbiBlbnN1cmluZyBGb29kIA0KU2VjdXJpdHkgcHJvZ3JhbXMgYXJlIGRlc2lnbmVk
LCBpbXBsZW1lbnRlZCBhcyBwbGFuIGFuZCB0aGF0IHRoZXkgaW1wcm92ZSB0aGUgDQp3ZWxs
LWJlaW5nIG9mIHRoZSB0YXJnZXQgY29tbXVuaXRpZXMuIFRoaXMgY291cnNlIGVxdWlwcyB0
aGUgcGFydGljaXBhbnRzIHdpdGggDQphZGVxdWF0ZSBza2lsbHMgdG8gZGV2ZWxvcCBhbmQg
bWFuYWdlIHJvYnVzdCBNJkUgc3lzdGVtcyBmb3IgZWZmZWN0aXZlIA0KbWFuYWdlbWVudCBv
ZiBGU04gcHJvZ3JhbXMuIFRoZSBsZWFybmVyIGlzIGludHJvZHVjZWQgdG8gRlNOIGluZGlj
YXRvcnMsIHRvb2xzIA0KYW5kIHRlY2huaXF1ZXMgZm9yIE0mRSBpbiBGU04uDQrCoA0KV2hv
IA0KU2hvdWxkIEF0dGVuZD8NClRoaXMgDQppcyBhIGdlbmVyYWwgdHJhaW5pbmcgaXMgdGFy
Z2V0aW5nIHZhcmlldHkgb2YgcHJvZ3JhbW1lIHN0YWZmLCBtYW5hZ2VtZW50IHRlYW0gDQpt
ZW1iZXJzIGFuZCB0aGVtYXRpYyBzdGFmZiwgUHJvamVjdCBNYW5hZ2VtZW50IE9mZmljaWFs
cywgZ292ZXJubWVudCBvZmZpY2lhbHMsIA0KcHJvZ3JhbW1lIG1hbmFnZXJzO8KgcG9saWN5
IG1ha2VycyBhbmQgcHJvZ3JhbW1lIA0KaW1wbGVtZW50ZXJzO8KgZGV2ZWxvcG1lbnQgcHJh
Y3RpdGlvbmVycyBhbmQgYWN0aXZpc3RzIGFuZCBOR08gYW5kIENTTyANCm1lbWJlcnMsIMKg
UmVzZWFyY2ggb3JnYW5pemF0aW9ucyBhbW9uZyBvdGhlcnMgZm9yIEFncmljdWx0dXJlIHN1
cHBvcnQgDQphY3Rpdml0aWVzLsKgwqANCsKgDQpObyANCm9mIERheXMNCjEwIA0KZGF5cw0K
wqANCkNvdXJzZSANCk9iamVjdGl2ZXMNCkdhaW4gDQogIHNraWxscyBpbiBib3RoIHF1YWxp
dGF0aXZlIGFuZCBxdWFudGl0YXRlIGRhdGEgY29sbGVjdGlvbiBhbmQgYW5hbHlzaXMgaW4g
DQogIE0mRSBmb3IgZm9vZCBzZWN1cml0eSBhbmQgbnV0cml0aW9uIHByb2dyYW1zLg0KU3Ry
ZW5ndGhlbiANCiAgdGhlaXIgY29tcGV0ZW5jZSBpbiB0aGUgZGVzaWduaW5nLCBtb25pdG9y
aW5nLCBhbmQgZXZhbHVhdGlvbiBvZiBGU04gDQogIHByb2dyYW1zLg0KR2FpbiANCiAgaW5z
aWdodCBpbnRvIHRoZSBwcmluY2lwbGVzIG9mIG1vbml0b3JpbmcsIGV2YWx1YXRpb24gYW5k
IGltcGFjdCBhc3Nlc3NtZW50IGluIA0KICBmb29kIGFuZCBudXRyaXRpb24gc2VjdXJpdHku
DQpBcHByZWNpYXRlIA0KICB0aGUgbmVlZCB0byBpbnRlZ3JhdGUgZ2VuZGVyIHJvbGUgaW4g
dGhlIGRldmVsb3BtZW50IG9mIEZTTiANCiAgcHJvZ3JhbXMuDQpDb21lIA0KICB1cCB3aXRo
IGNsZWFyIGlkZWFzIGZvciBpbXByb3ZpbmcgbW9uaXRvcmluZywgZXZhbHVhdGlvbiBhbmQg
aW1wYWN0IA0KICBhc3Nlc3NtZW50cyBmb3IgZm9vZCBzZWN1cml0eSBhbmQgbnV0cml0aW9u
IA0KcHJvZ3JhbXMuDQpDb3Vyc2UgDQpDb250ZW50DQpNb2R1bGUgDQoxOsKgRnVuZGFtZW50
YWxzIG9mIE1vbml0b3JpbmcgYW5kIEV2YWx1YXRpb24NCldoYXQgDQogIGlzIE0mRT8NClNp
Z25pZmljYW5jZSANCiAgb2YgTSZFDQpQcmluY2lwbGVzIA0KICBhbmQgY29uY2VwdHMgaW4g
TSZFDQpNJkUgDQogIGFuZCB0aGUgcHJvamVjdCBsaWZlY3ljbGUNCkNvbXBsZW1lbnRhcnkg
DQogIHJvbGVzIG9mIG1vbml0b3JpbmcgYW5kIGV2YWx1YXRpb24NCk1vZHVsZSANCjI6IEZv
b2QgU2VjdXJpdHkgYW5kIE51dHJpdGlvbiBNJkUgRnJhbWV3b3Jrcw0KRm9vZCANCiAgc2Vj
dXJpdHkgYW5kIG51dHJpdGlvbiBjb25jZXB0dWFsIGZyYW1ld29ya3MNCkZvb2QgDQogIHNl
Y3VyaXR5IGFuZCBudXRyaXRpb24gcmVzdWx0cyBmcmFtZXdvcmtzDQpMb2dpY2FsIA0KICBm
cmFtZXdvcmsgYW5hbHlzaXMNCkZvb2QgDQogIHNlY3VyaXR5IGFuZCBudXRyaXRpb24gcHJv
amVjdHMgZGVzaWduIHVzaW5nIA0KTG9nRnJhbWVzDQpNb2R1bGUgDQozOiBGb29kIFNlY3Vy
aXR5IGFuZCBOdXRyaXRpb24gSW5kaWNhdG9ycw0KRm9vZCANCiAgc2VjdXJpdHkgYW5kIG51
dHJpdGlvbiBpbmRpY2F0b3JzDQpJbmRpY2F0b3IgDQogIG1ldHJpY3MNCkxpbmsgDQogIGJl
dHdlZW4gaW5kaWNhdG9ycyBhbmQgwqByZXN1bHRzDQpJbmRpY2F0b3IgDQogIE1hdHJpeA0K
RlNOIA0KICBpbmRpY2F0b3IgcGVyZm9ybWFuY2UgdHJhY2tpbmcNCk1vZHVsZSANCjQ6IE0m
RSBTeXN0ZW0gZGVzaWduIGFuZCBNJkUgUGxhbm5pbmcgaW4gRlNODQpJbXBvcnRhbmNlIA0K
ICBvZiBhbiBNJkUgUGxhbg0KQ29tcG9uZW50cyANCiAgb2YgYW4gTSZFIFBsYW4NCkRlc2ln
biANCiAgUHJpbmNpcGxlcyBmb3IgbW9uaXRvcmluZyBhbmQgZXZhbHVhdGlvbg0KVXNpbmcg
DQogIE0mRSBwbGFuIHRvIGltcGxlbWVudCBNJkUgaW4gYSBwcm9qZWN0DQpNJkUgDQogIHBs
YW4gYWdhaW5zdCBwZXJmb3JtYW5jZSBtYW5hZ2VtZW50IHBsYW4NCk1vZHVsZSANCjU6IE0m
RSBDb25zaWRlcmF0aW9ucyBmb3IgU2VjdG9yIFNwZWNpZmljIFByb2dyYW1taW5nDQpGb29k
IA0KICBhdmFpbGFiaWxpdHkNCkZvb2QgDQogIGFjY2Vzcw0KRm9vZCANCiAgdXRpbGl6YXRp
b24NClN0YWJpbGl0eQ0KTWFya2V0IA0KICBJbmZvcm1hdGlvbg0KTW9kdWxlIA0KNjogTSZF
IENvbnNpZGVyYXRpb25zIGZvciBIZWFsdGggYW5kIE51dHJpdGlvbsKgDQpTZWxlY3Rpb24g
DQogIG9mIGluZGljYXRvcnMNCkludGVncmF0ZWQgDQogIGRpc2Vhc2Ugc3VydmVpbGxhbmNl
IGFuZCBudXRyaXRpb24gc3VydmVpbGxhbmNlIHN5c3RlbXMNCk51dHJpdGlvbg0KTW9kdWxl
IA0KNzogRGF0YSBNYW5hZ2VtZW50IGZvciBNJkUgaW4gRlNODQpTb3VyY2VzIA0KICBvZiBN
JkUgZGF0YQ0KUXVhbGl0YXRpdmUgDQogIGRhdGEgY29sbGVjdGlvbiBtZXRob2RzDQpRdWFu
dGl0YXRpdmUgDQogIGRhdGEgY29sbGVjdGlvbiBtZXRob2RzDQpQYXJ0aWNpcGF0b3J5IA0K
ICBtZXRob2RzIG9mIGRhdGEgY29sbGVjdGlvbg0KTW9kdWxlIA0KODrCoERhdGEgQW5hbHlz
aXMgd2l0aCBTUFNTL1NUQVRBL1Igb3IgwqBQeXRob24NCkRhdGEgDQogIGNsZWFuaW5nDQpR
dWFsaXRhdGl2ZSANCiAgZGF0YSBhbmFseXNpcw0KUXVhbnRpdGF0aXZlIA0KICBkYXRhIGFu
YWx5c2lzDQpEYXRhIA0KICBpbnRlcnByZXRhdGlvbiBhbmQgcmVwb3J0aW5nDQpNb2R1bGUg
DQo5OiBHZW5kZXIgY29uc2lkZXJhdGlvbiBpbiBNJkUgZm9yIEZTTg0KR2VuZGVyIA0KICBp
bnRlZ3JhdGlvbiBkdXJpbmcgcHJvamVjdCBhY3Rpdml0aWVzIGRlc2lnbg0KR2VuZGVyIA0K
ICBpbmRpY2F0b3JzIGluIGZvb2Qgc2VjdXJpdHkgYW5kIG51dHJpdGlvbiBwcm9ncmFtcw0K
Q3Jvc3MtY3V0dGluZyANCiAgZ2VuZGVyIGlzc3VlcyBpbiBGU04NClJvbGUgDQogIG9mIE0m
RSBpbiBhZGRyZXNzaW5nIGdlbmRlcg0KTWVhc3VyZSANCiAgb2YgZ2VuZGVyIG91dGNvbWVz
DQpNb2R1bGUgDQoxMDogRXZhbHVhdGlvbiBvZiBGb29kIFNlY3VyaXR5IGFuZCBOdXRyaXRp
b24gUHJvZ3JhbXMNCkRldGVybWluaW5nIA0KICBldmFsdWF0aW9uIHBvaW50cyBmcm9tIHJl
c3VsdHMgZnJhbWV3b3JrDQpDb21wb25lbnRzIA0KICBvZiBldmFsdWF0aW9ucywgaW1wbGVt
ZW50YXRpb24gYW5kIHByb2Nlc3MgZXZhbHVhdGlvbnMNCkV2YWx1YXRpb24gDQogIGRlc2ln
bnMNClBlcmZvcm1hbmNlIA0KICBldmFsdWF0aW9uIHByb2Nlc3MNCkV2YWx1YXRpb24gDQog
IGZpbmRpbmdzLCBzaGFyaW5nLCBhbmQgZGlzc2VtaW5hdGlvbg0KTW9kdWxlIA0KMTE6IElt
cGFjdCBBc3Nlc3NtZW50IG9mIEZTTiBQcm9ncmFtcw0KSW50cm9kdWN0aW9uIA0KICB0byBp
bXBhY3QgZXZhbHVhdGlvbg0KSW1wYWN0IA0KICBhc3Nlc3NtZW50IGluIHByb2dyYW0gZGVz
aWduDQpBdHRyaWJ1dGlvbiANCiAgaW4gaW1wYWN0IGV2YWx1YXRpb24NCkltcGFjdCANCiAg
ZXZhbHVhdGlvbiBtZXRob2RzDQpNb2R1bGUgDQoxMjogTSZFIFJlc3VsdHMgVXNlIGFuZCBE
aXNzZW1pbmF0aW9uDQpVc2UgDQogIG9mIE0mRSByZXN1bHRzIHRvIGltcHJvdmUgYW5kIHN0
cmVuZ3RoZW4gRlNOIA0KICBwcm9qZWN0cw0KVXNlIA0KICBvZiBNJkUgTGVzc29ucyBsZWFy
bmVkIGFuZCBiZXN0IHByYWN0aWNlcw0KTSZFIA0KICByZXBvcnRpbmcNCkRlc2lnbiwgDQog
IG1vbml0b3JpbmcsIGFuZCBldmFsdWF0aW9uIG9mIHJlc2lsaWVuY2UgDQppbnRlcnZlbnRp
b25zDQoNCg0KwqANCsKgR2VuZXJhbCBOb3Rlcw0KQWxsIA0KICBvdXIgY291cnNlcyBjYW4g
YmUgVGFpbG9yLW1hZGUgdG8gcGFydGljaXBhbnRzIG5lZWRzIA0KVGhlIA0KICBwYXJ0aWNp
cGFudCBtdXN0IGJlIGNvbnZlcnNhbnQgd2l0aCBFbmdsaXNoIA0KUHJlc2VudGF0aW9ucyAN
CiAgYXJlIHdlbGwgZ3VpZGVkLCBwcmFjdGljYWwgZXhlcmNpc2UsIHdlYiBiYXNlZCB0dXRv
cmlhbHMgYW5kIGdyb3VwIHdvcmsuIE91ciANCiAgZmFjaWxpdGF0b3JzIGFyZSBleHBlcnQg
d2l0aCBtb3JlIHRoYW4gMTB5ZWFycyBvZiBleHBlcmllbmNlLiANCiAgDQpVcG9uIA0KICBj
b21wbGV0aW9uIG9mIHRyYWluaW5nIHRoZSBwYXJ0aWNpcGFudCB3aWxsIGJlIGlzc3VlZCB3
aXRoIEZvc2NvcmUgZGV2ZWxvcG1lbnQgDQogIGNlbnRlciBjZXJ0aWZpY2F0ZSAoRkRDLUsp
IA0KVHJhaW5pbmcgDQogIHdpbGwgYmUgZG9uZSBhdCBGb3Njb3JlIGRldmVsb3BtZW50IGNl
bnRlciAoRkRDLUspIGNlbnRlciBpbiBOYWlyb2JpIEtlbnlhLiBXZSANCiAgYWxzbyBvZmZl
ciBtb3JlIHRoYW4gZml2ZSBwYXJ0aWNpcGFudHMgdHJhaW5pbmcgYXQgcmVxdWVzdGVkIGxv
Y2F0aW9uIHdpdGhpbiANCiAgS2VueWEsIG1vcmUgdGhhbiB0ZW4gcGFydGljaXBhbnQgd2l0
aGluIGVhc3QgQWZyaWNhIGFuZCBtb3JlIHRoYW4gdHdlbnR5IA0KICBwYXJ0aWNpcGFudCBh
bGwgb3ZlciB0aGUgd29ybGQuIA0KQ291cnNlIA0KICBkdXJhdGlvbiBpcyBmbGV4aWJsZSBh
bmQgdGhlIGNvbnRlbnRzIGNhbiBiZSBtb2RpZmllZCB0byBmaXQgYW55IG51bWJlciBvZiAN
CiAgZGF5cy4gDQpUaGUgDQogIGNvdXJzZSBmZWUgaW5jbHVkZXMgZmFjaWxpdGF0aW9uIHRy
YWluaW5nIG1hdGVyaWFscywgMiBjb2ZmZWUgYnJlYWtzLCBidWZmZXQgDQogIGx1bmNoIGFu
ZCBhIENlcnRpZmljYXRlIG9mIHN1Y2Nlc3NmdWwgY29tcGxldGlvbiBvZiBUcmFpbmluZy4g
UGFydGljaXBhbnRzIA0KICB3aWxsIGJlIHJlc3BvbnNpYmxlIGZvciB0aGVpciBvd24gdHJh
dmVsIGV4cGVuc2VzIGFuZCBhcnJhbmdlbWVudHMsIGFpcnBvcnQgDQogIHRyYW5zZmVycywg
dmlzYSBhcHBsaWNhdGlvbiBkaW5uZXJzLCBoZWFsdGgvYWNjaWRlbnQgaW5zdXJhbmNlIGFu
ZCBvdGhlciANCiAgcGVyc29uYWwgZXhwZW5zZXMuIA0KQWNjb21tb2RhdGlvbiwgDQogIHBp
Y2t1cCwgZnJlaWdodCBib29raW5nIGFuZCBWaXNhIHByb2Nlc3NpbmcgYXJyYW5nZW1lbnQs
IGFyZSBkb25lIG9uIHJlcXVlc3QsIA0KICBhdCBkaXNjb3VudGVkIHByaWNlcy4gDQpPbmUg
DQogIHllYXIgZnJlZSBDb25zdWx0YXRpb24gYW5kIENvYWNoaW5nIHByb3ZpZGVkIGFmdGVy
IHRoZSBjb3Vyc2UuIA0KICANClJlZ2lzdGVyIA0KICBhcyBhIGdyb3VwIG9mIG1vcmUgdGhh
biB0d28gYW5kIGVuam95IGRpc2NvdW50IG9mICgxMCUgdG8gNTAlKSBwbHVzIGZyZWUgZml2
ZSANCiAgaG91ciBhZHZlbnR1cmUgZHJpdmUgdG8gdGhlIE5hdGlvbmFsIGdhbWUgcGFyay4g
DQpQYXltZW50IA0KICBzaG91bGQgYmUgZG9uZSB0d28gd2VlayBiZWZvcmUgY29tbWVuY2Ug
b2YgdGhlIHRyYWluaW5nLCB0byBGT1NDT1JFIA0KICBERVZFTE9QTUVOVCBDRU5URVIgYWNj
b3VudCwgc28gYXMgdG8gZW5hYmxlIHVzIHByZXBhcmUgYmV0dGVyIGZvciB5b3UuIA0KICAN
CkZvciANCiAgYW55IGVucXVpcnkgdG86dHJhaW5pbmdAZmRjLWsub3JnIG9yICsyNTQ3MTIy
NjAwMzENCsKgDQpPVEhFUiANClVQQ09NSU5HIFdPUktTSE9QUyBGT1IgwqBERUMgwqAyMDIx
ICggQ0xJQ0sgTElOSyBUTyBSRUdJU1RFUiBGT1IgVEhFIA0KV09SS1NIT1AgQVMgSU5ESVZJ
RFVBTCBPUiBHUk9VUCkNCsKgDQoNCg0KPGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90
cmFja2luZy9jbGljaz9kPXJXN2t2OWFlM1JJWkdOTEVKUEFtYkdvSXpiYXhXT2dlS29kUTJw
cUFVSlQ5ZkdHbVk3QldKSW5KZUIwYVFaRFg1ZHE1QzNJT2M0YXBsS3dTN0wwRnYzR2o4TlAw
Mm1MamhpMUxzbzV6VTdYX2RBR3I1YnRwTGJBU2FGd1J5OXJyZThpSFFwNUpOVlZVbUN4SWJp
dXp2eGpSaGJHZUJJdXRmbjhYV0djXzJJSGVWZDF2LThMaTFRaUlKeWZMeXlvOHNPT2h6WUJh
SkZRQ2R3ZEtqV3U5MzVubGt4VjFoT2pMVnVTUjRjck05cmhHNDNvSDNrZGo2SV9Zdk1jeXRf
aWRzZzI+DQpQcm9qZWN0IFByb3Bvc2FsIGFuZCBSZXBvcnQgV3JpdGluZyBza2lsbCANCiAg
ICAgICAgV29ya3Nob3ANCg0KPGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2lu
Zy9jbGljaz9kPVFPWk5NV3Z6b1huTUtJMmZHaDVuYWJSWVFycGV3X3g5VUQ5d0o1dm90TUZX
OHZ5MU9pblQ1V0c1MXRmdzlGYVNTSWhhRGVYOVJiT0xHaE1FRFhIQXVpOWU4VkJVeWRwaWZJ
MDRycmJYRF85eGVNQjNRZVIxeW9TcVZKbUpQaWtRSGtnTGJTOUl3aWcxWHY1RE82anpmM3hx
YndHRHlJZUhULVFfZ19oT3BOWVJnYnNuRVEtY3VCbmljX3JTSjEzTUJMTnp1eVFiWmtFVklh
TUxWdnRWYlR6aThsMmVWVnRCeS10ZmE3VEZQalVvMD4NCkdJUyBBcHBsaWNhdGlvbiBpbiBE
aXNhc3RlciBSaXNrIFJlZHVjdGlvbiANCiAgICAgICAgV29ya3Nob3ANCg0KPGh0dHA6Ly90
cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9kPW5PYzhRNi1HbktWVUlwZ1JQ
SHZ1Q0xqT25PQTVzWXRQRmw3aTktRjNiSDQ5NkRNZkFPbXVZdE04cFNPMEZZZmNDRGt5LVZk
bFRqMm93NktOaW11SnVnZEtvMHhvVWI2SGE3QmVET3lQVm1nbW5ocVJUTHVsNHFjZU1NdXd0
ZHY5ZG9Nek1IdTZnckJlX0lybWpvUU1FeTB4OVhRelBrZ1AwQ0hPOEZYTUhLRXJ0UHJSTUUt
NlBsWm9OS1JxbHBnLUlBZ0h3clB0QXdBZjg0WXJ3U3BxR0FuVENWUmtycENBdTVSNFU1MVh0
Vm5QQVNZMEVUOVpUNTU4RFhROUxfc0t5UFZ5a1doV0ZMRkdPNnFNMUxIY2R5azE+DQpHSVMg
YW5kIERhdGEgQW5hbHlzaXMgZm9yIFdBU0ggKFdhdGVyIFNhbml0YXRpb24gYW5kIA0KICAg
ICAgICBIeWdpZW5lKSBQcm9ncmFtbWVzIFdvcmtzaG9wDQoNCjxodHRwOi8vdHJhY2tpbmcu
ZmRjLWsub3Iua2UvdHJhY2tpbmcvY2xpY2s/ZD1zU19fMGVyZXBqR3o3bk5XTEtvTy1BaHBK
QTNFLUtfWk9oN3R6aUtfZTdUd0hUQW0xZUdCRmVsSmVuaS1RcTFFejQxdXo3aWRlSV9zYXFG
SFZYbGRMbVZ6SU15VllIc1VIMFFPT3N3Q3BPMVZjYkN4QUphS2tTb21mX3ppM056R3pwMmRP
VmFMSHM2SDlJUXNvOU9aLURMX2lZbnN6SkVmMXJ0VlNWY0hBanBCNTFMd3gtb1FuNHA2dzlB
T0luc085U3FiR3dfX3U1WjJPZ3FLS2hqdFlDdE5XMjNlTXdMazQ2MXdJVXNoLVM0RDA+DQpH
cmFudCBNYW5hZ2VtZW50IGFuZCBGdW5kcmFpc2luZyANCiAgICAgICAgV29ya3Nob3ANCg0K
PGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9kPUgwSjRvaV9l
djZhOTd4T1E1WS00bUs0WXU1NVlXNFZMaEZqeXpzdVhjbGZSMHVaWkFFSmtycTJnM1FvZG9P
bTNoNnBiMW9rSUtycmtma0tOc0FFN2NsM19rR0JaRjRXMTItRmd5cExBU3E4aTVkeFFLTWpB
VHhKMXJaM0ZPWVdsLWpaUTdUbzgzcUdaZUlhZU9BeTk4OEpJM2Rjc2FhY0RRTWRmRkJ3RG85
T2Q3NUtTUzJSN0dnTmhlSF9KZFE1Qy1YTXQ4VDNva1p1c0k3d1d3NGRwUjFvY3ZMYVZ3Q2JS
blMzUkdfY21yazg5RTg2RW1Jc0Z1bTg5X1p5SzI5WDJ6dzI+DQpIdW1hbiBSZXNvdXJjZXMg
TWFuYWdlbWVudCBhbmQgRGV2ZWxvcG1lbnQgDQogICAgICAgIFdvcmtzaG9wDQoNCjxodHRw
Oi8vdHJhY2tpbmcuZmRjLWsub3Iua2UvdHJhY2tpbmcvY2xpY2s/ZD10MzRtU1JfLUpPMmNZ
Rjhzb0p3eEZVMjI5REtKYVF0cURjQ0pCWG1YUDZ1RnNwcXpvaGc4MncyaExLZ19qYWtHdzUt
WVR5amgwcVU4VkVhWEJ2a1V0ZTJybDVnT0VJV2lyVE1Uam5yc0ppMmRPMWdMMmV5QmlQQ3J4
Qi10Z0Jha3NHRFFwYTN3RXJ4czlNTm9MNGd6U3VhcG9BMXA0U193a1ZoZzhKQzB6Q18wNkw0
QVJwWFhYUkNIQTV0M0FEX0RWa1ZXWHRoZTZWcjI5RTJDSmJLTEk2cF9kV2hWdGo2anBzM3Et
OEI0RUFZem1kaDk4OVQ1MVlqOG1NVlV5NVRrc3cyPg0KQWNjb3VudCBNYW5hZ2VtZW50IGFu
ZCBCdXNpbmVzcyBEZXZlbG9wbWVudCANCiAgICAgICAgV29ya3Nob3ANCg0KPGh0dHA6Ly90
cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9kPWh5Rk13dnFsd0NyM0ZDUGFT
akFnZ3hvSHJheWppdDhhSHNDTm5zX2JYMUFHZHpuaXhONUhYY3Vnc3R3MnF0ZlBXM0U2a1ZV
b0ZXN0dkMk9ycVZPaWZJSWFvT0JVc3ZvcGlOY0N1VlFiajMxVjZHVThvUUlCNERZZ0RJbjRy
YzFTM0lZRklvR0N4ZEEyN1lETjRodmtzMTFnaW5ZekV6OF96R1V0ZC1EbWZOY2ZQZURCSGF3
TGE4c2x6N2lTS2w1OVJnTFRqa05XMjFmTXRuQmtIQjluelhNVWZEc0dNSjdFR3BxMlF1N0wz
UnVEa0tKRnBycmVYN2ltV09zRGhXdDNOT19kb2JLbGlrQVBYOEdzT0RxTERqNDE+DQpBZHZh
bmNlZCBNb25pdG9yaW5nIGFuZCBFdmFsdWF0aW9uIGZvciBEZXZlbG9wbWVudCBSZXN1bHRz
IA0KICAgICAgICBXb3Jrc2hvcA0KDQo8aHR0cDovL3RyYWNraW5nLmZkYy1rLm9yLmtlL3Ry
YWNraW5nL2NsaWNrP2Q9RlpaM2FQaUthMW15ejFUTXlDeWNLRDFZSWtoMFJqWkJ6a1FzZjJs
bDRQVnhsNVVZQ05MN0lnRFQ1OURnX1FlaU1MZDAyNGtLekJOZldsd2dRdWFOWHRhUF9FZG5w
TnFncTBzVFdYdDNVQmtnVHhMMVVQcDdFV0w0NnRtZnhDMHJRYjNCckpEUkRkYjNTSGpNalEx
MWlRS1FZZkdFdGlYWFZPRXBUaDNzQUR4Z2s5dGtjbkFoVDEyUmUyVEVPSnBnM2NQcWx2VHBl
RDNWREhxNWdtWjVZMlMyODVHQlJKRzJTclppRmViNlFpclZ4NGlLQVdIck9aNG42YUE1MlF5
QXBnMj4NCkV4ZWN1dGl2ZSBMZWFkZXJzaGlwICYgTWFuYWdlbWVudCBQcm9ncmFtIA0KICAg
ICAgICBXb3Jrc2hvcA0KDQo8aHR0cDovL3RyYWNraW5nLmZkYy1rLm9yLmtlL3RyYWNraW5n
L2NsaWNrP2Q9SDBKNG9pX2V2NmE5N3hPUTVZLTRtSzRZdTU1WVc0VkxoRmp5enN1WGNsZElr
U1VMMjRqRmRoS3A3OWVQZE1TM0xoTjhnQmFpanJtQjBCa1RZeEhraEk2VlVGV3hjbGctT29N
R0lSUjNUNnlDRFcxdVBhNXhXdlAxN1NQRGFQUkZWamY3Zi1QMlRDbVIzZTlMMU1BanVuS3hz
bW1fV1cyMW9xOTVuNXVpRkE1a3Zvc2p2cU5oWnRXQkJKQlptSVJrc2FsSDBsN3I4SU1icFFx
ejFMRHpnY3pXNExNdWY2SDVtYXQtcGdvX3RocVMzTm9IQWYxNjhfY0gteTF2T2ZJQ2tRMj4N
ClByb2N1cmVtZW50IGxvZ2lzdGljcyBhbmQgU3VwcGx5IENoYWluIE1hbmFnZW1lbnQgDQog
ICAgICAgIFdvcmtzaG9wDQoNCjxodHRwOi8vdHJhY2tpbmcuZmRjLWsub3Iua2UvdHJhY2tp
bmcvY2xpY2s/ZD1oeUZNd3ZxbHdDcjNGQ1BhU2pBZ2d4b0hyYXlqaXQ4YUhzQ05uc19iWDFB
R2R6bml4TjVIWGN1Z3N0dzJxdGZQVzNFNmtWVW9GVzdHZDJPcnFWT2lmSUlhb09CVXN2b3Bp
TmNDdVZRYmozMVY2R1U4b1FJQjREWWdESW40cmMxUzNJWUZJb0dDeGRBMjdZRE40aHZrczEx
Z2luWXpFejhfekdVdGQtRG1mTmNmUGVEQkhhd0xhOHNsejdpU0tsNTlRVDdkVXp5ejJPaDI1
UWVPMXNqX01CQ3FRQmZhOVh6Zjl2TDJxWkotWERob3NTczZpalhscjVmZk50c3ZtZVBiTXBz
aXk4Y1NsSDVfR1N2ZGNiQlFyMHcxPg0KQWR2YW5jZWQgTW9uaXRvcmluZyBhbmQgRXZhbHVh
dGlvbiBmb3IgRGV2ZWxvcG1lbnQgUmVzdWx0cyANCiAgICAgICAgV29ya3Nob3ANCg0KPGh0
dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9kPV9tWFpqM2ZXUkdv
T2xTN1JMaDdCcm1kdm5TTkxjYU5FcWdqLXZqRnlsSGw4OVRtRmV4b0I4a2tyNk5mc2gzeEJu
U3lVNy1idWdxSnVUZkloai1ZTW16WGVSWkpSVG9kd2JzbmMyTm1aVE9Ra2EyX0dnd0JVdFVB
YlpEY1h6ZW41TS1CTG5vZ1NSd01tVENQZ3FSTzlYekU2MzdHU2lka2NrNGl4TnFTNG1XYWZ0
azhNdlNvbUZDRUtCTGFyNU9IV1Y3cVRmRU1wWlpzVmRGYkxhQkk3Z0s1cmE4LUx6b1JKV1c5
TEFRQU5rR3Z1OG9HSmUzTVJWaWpkU085OWZVWnQzLUtoYTNFMnRkYUs0QzFXZ1VxNUpFVHVn
SFFPT3VVb05KUzlMZWZwNHgyUUN1eHdTcDdrRFh4OC1VOUJLOWZ2WmcyPg0KUmVzZWFyY2gg
RGVzaWduLCBPREsgTW9iaWxlIERhdGEgQ29sbGVjdGlvbiwgR0lTIE1hcHBpbmcsIA0KICAg
ICAgICBEYXRhIEFuYWx5c2lzIHVzaW5nIE5WSVZPIGFuZCBTUFNTIA0KICAgICAgICBXb3Jr
c2hvcA0KDQo8bWFpbHRvOnRyYWluaW5nQGZkYy1rLm9yZz9zdWJqZWN0PVJFOiBJbnF1aXJp
bmcgb24+DQpTZW5kIHVzIA0KICAgICAgRW1haWwNCsKgDQpDb3Vyc2UgDQogICAgICBQcm9n
cmFtbWUNCg0KPGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9k
PVQ2bEN5OHBwN3FhUW0yc3ZzVzBSTzBsU2RMMWthbDlvS184UkhrMjBBMHltR3FtaGEzcmFE
elA3b09JeldQUFdtNTBUTUptUnBpUmtmTF8yWWNlSk5BQ1dmV3Q4RVR4ZU12bk1xTGhjVVNo
NXFEdkdFZW5jQUdwRm41cEw0alNwSHBQenY3VU01YmRXR2RWZzVQc1NreEx4d1JVeWZnMjZi
cVA3STRCU0V2bkowPg0KUmVzZWFyY2ggYW5kIERhdGEgQW5hbHlzaXMgcHJvZmVzc2lvbmFs
IHNob3J0IA0KICAgICAgICBjb3Vyc2VzDQoNCjxodHRwOi8vdHJhY2tpbmcuZmRjLWsub3Iu
a2UvdHJhY2tpbmcvY2xpY2s/ZD1vSVlsZW1TM3RreUpkbk1xRnRnRHNOWFc3UDRSVlhHQTlR
QXFWWDF6SExoSjZWUDg4cFZiaDZpVUsweWpjYkQzN2NheWRQWUtnYmVOR09CV3dfN1R4WkxV
d01hckZ1OVhjeEZUQjZhUVRmeDA5VGgxNDRrUmcyVHFteFBqU3FSWHBzLWVRVkJ0Tkd5cndK
WENpcGxhU2ZjUXFaMWd3eDZYRFBBR0M2OVZ6elBiMD4NCk1vbml0b3JpbmcgYW5kIEV2YWx1
YXRpb24gcHJvZmVzc2lvbmFsIHNob3J0IA0KICAgICAgICBjb3Vyc2VzDQoNCjxodHRwOi8v
dHJhY2tpbmcuZmRjLWsub3Iua2UvdHJhY2tpbmcvY2xpY2s/ZD1EVWtfNWN1YnJHNFZ6T0Z4
Tk9yZ0pGbG5sdGtKdmZkNWxBVDRSMWpsal9tTG82WnkySzIteHhXamwwQTd0R1JOWWc3V2tK
UHpRNHJZT0xyTUs0Z1NUbmt1eFFkQk9OTkJSMDVsd1o4RkdFX3ZXb2M3TFRKWnpDZW9odTdP
c1FXUlViSlhvRERYNHhrckwxUHBoeWdnSTZSNXF4UlM4aUVuQTFTOE5rZWhjSkp1MD4NCkh1
bWFuaXRhcmlhbiBhbmQgU29jaWFsIERldmVsb3BtZW50IHByb2Zlc3Npb25hbCBzaG9ydCAN
CiAgICAgICAgY291cnNlcw0KDQo8aHR0cDovL3RyYWNraW5nLmZkYy1rLm9yLmtlL3RyYWNr
aW5nL2NsaWNrP2Q9LWJ1TGpiTTlMNktPcmU0QzhoVVBIZE5ud29sQ1p5VXIwSUh1N2NSeUpT
UGlxOGJPWFVubV83NnhhaUp5NHJhUnZWelBWM0FjVkdueWdmS3llYjFudlJwX0d0TzJjR1Bk
eHh0QUV2bTJPMUpCNHhHb3kwZjZ3T0w0TThfekFlMGUzU2VHZVQ1eXhPaGUyNEhWTjByTi1H
NHg3TG1JSlF5UWJyd0M5MTZEbGMxVjA+DQpJbmZvcm1hdGlvbiBUZWNobm9sb2d5IHByb2Zl
c3Npb25hbCBzaG9ydCANCiAgICAgICAgY291cnNlcw0KDQo8aHR0cDovL3RyYWNraW5nLmZk
Yy1rLm9yLmtlL3RyYWNraW5nL2NsaWNrP2Q9ejkwa3AzWGpJaXlRa1pRS0tVUi1sSURaY0Nk
QXYtU1pWdjl3SVlOb01ucEZCaUUtVGlTLVZjc3pGdVJmcmRoTXJMWmhXMkJyQURGdVpHQ05q
NGtLc0pXeC1lMmo0TnV6d19kcVBHRWRjLUpUWV94ZUFsTlRyR2FtajExbE5PZDVMLTBXUFlh
ZjRLanNYT2RYbHFyd1RDazE+DQpBZ3JpY3VsdHVyZSBwcm9mZXNzaW9uYWwgc2hvcnQgY291
cnNlcw0KDQo8aHR0cDovL3RyYWNraW5nLmZkYy1rLm9yLmtlL3RyYWNraW5nL2NsaWNrP2Q9
NXJ5dmM4VHNRODVod3F5ZWpzS1hLVkRuZGdlZFYyU05iU3doU0k1bHFqWlgzQlNhc19YSG1K
ekpTeVRaZ0h1ZERtRkU0OXNMUzZOM0JYWDNTM25Nd3Y0TU1INHZXbHRIWjgxaXR2VlA0eXZ2
X2lZdTE2ZTc5Q1R3UWdPVzdKSldieU01cDBzTUFNTGlKa2lodGlNOGJfTTE+DQpHSVMgJiAN
CiAgICAgICAgUmVtb3RlIFNlbnNpbmcgcHJvZmVzc2lvbmFsIHNob3J0IGNvdXJzZXMNCg0K
PGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9jbGljaz9kPWJuWXRrVU5Q
aTNzR1F4ZFF4N18tSjg5NWVWQ09SbXFVcWk0WmtXa3NMaTUxNS1pdnFUOFI0d3pJaHlzUlox
bFkzLW1YNFY1RlhiWlpreC1MRWd6TjhEMDFpNGZxUzIwSDBuV1lKdTFOb2JMWmc2RExWXzhL
Vmd5OVlVWl93NDA3QjF4X0ZXSXF6T0VjQ0FoYVJYc1NCZTdrU1VUWlhPT2tROU1jTjZ5TjhU
ZjQwPg0KQnVzaW5lc3MgYW5kIEdvdmVybmFuY2UgcHJvZmVzc2lvbmFsIHNob3J0IA0KICAg
ICAgICBjb3Vyc2VzDQoNCjxodHRwOi8vdHJhY2tpbmcuZmRjLWsub3Iua2UvdHJhY2tpbmcv
Y2xpY2s/ZD1ES25ISlE4OUl1WUtoRm1VdGVQVEZ4OHRReWxjYktTMmRwdzQteFhpRGdMTkwz
X2pTdVpmVXZSZFFuUS14a3B0NmpsWWhIVUpwNGFNQkFRbGp1cHZRTXFYb0dwTEdoLS1yeGpo
T2JpY2lqS2lRSGNQbmVQbGIxYkZMQm5UMWtlVXZLOU54Z3dOV0hiNXp1T3N4OHMzZWw4MT4N
CkNob29zZSB5b3VyIA0KICAgICAgICBPbmxpbmUgVHJhaW5pbmcgQ291cnNlDQoNCjxodHRw
Oi8vdHJhY2tpbmcuZmRjLWsub3Iua2UvdHJhY2tpbmcvY2xpY2s/ZD1Qbk02ZTZDb1JuWjU5
cGs0Vm82Y1lhdWNUWjJrOFZVUHVIX0FGU3Nta3J0eWtaNEhWNmhsMlZNNFZpTDduXzFIdE1U
TklRUXdLV1ZOSHNDWXBfTnhuSHdCR2hYeXZWLWwwODVEWV9FOXVzV1ZVeER1ckd0MGdBX2sx
Sjh5aWxHd0dVQ2I3aG9CUGFDMUg2RW8zMTVBQmhnMT4NCmNvbnN1bHRhbmN5IA0KICAgICAg
ICBzb2x1dGlvbnMNCg0KPGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFja2luZy9j
bGljaz9kPWJuWXRrVU5QaTNzR1F4ZFF4N18tSjg5NWVWQ09SbXFVcWk0WmtXa3NMaTUxNS1p
dnFUOFI0d3pJaHlzUloxbFkzLW1YNFY1RlhiWlpreC1MRWd6TjhLM2RKakVYWHpRejRWeTAy
d1d2bi1PNldHdmF4X3AzMnZUVzBWSVFlU2xzcmNicFhuLTdFQk9YYkRhTnFFYXVtUEFMaG0w
aTZXSlhpc1FOOXR6TDZ3aXkwPg0KT3VyIDIwMjEgLSAyMDIyIFByb2Zlc3Npb25hbCBTaG9y
dCBUcmFpbmluZyANCiAgICAgICAgQ291cnNlcw0KwqANCkxvb2tpbmcgDQpmb3J3YXJkIHRv
IHlvdXIgwqBhdHRlbmRhbmNlLg0KwqANCkZEQyANClJlc3VsdCBCYXNlZCBza2lsbHMgRGV2
ZWxvcG1lbnQNClJlZ2FyZHMsDQpUcmFpbmluZyANCkNvb3JkaW5hdG9yDQoNClRlbGVwaG9u
ZSANCm9mZmljZTogKzI1NDcxMjI2MDAzMQ0KwqANCg0KPG1haWx0bzp0cmFpbmluZ0BmZGMt
ay5vcmc/c3ViamVjdD1SRTogSW5xdWlyaW5nIG9uPg0KU2VuZCB1cyANCkVtYWlsDQrCoA0K
WW91IA0KY2FuIG9wdCBvdXQgb2YgZnV0dXJlIGNvbW11bmljYXRpb25zIGFib3V0IG91ciBz
ZXJ2aWNlcyBieSBjbGlja2luZyBvbiB0aGUgDQp1bnN1YnNjcmliZSBsaW5rIGJlbG93LlRo
YW5rIHlvdQ0KwqANCsKgDQrCoA0KPGh0dHA6Ly90cmFja2luZy5mZGMtay5vci5rZS90cmFj
a2luZy91bnN1YnNjcmliZT9kPVdvRjJ2S2hWa1dZRDdQLUNRYVkwOWx6enZlVmNqd3B6SVdt
SC03c1FFbnMtOTBIOW5lWjY5cWFIeUxWamROeFlSZ0FjWnZBRDFLMTZDRG50SUJxYThLQlph
TFFZTWZWQjg5RmgxYzRHc0ltZDA+DQpVTlNVQlNDUklCRQ==

--=-eZCfXDDh5HSad+SkYO1/TAHq4S923tI/y3WKzQ==
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:o =3D "urn:schemas-microsoft-com:office:office"><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Ty=
pe>
<META name=3DGENERATOR content=3D"MSHTML 6.00.6000.16546"></HEAD>
<BODY>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3D_vXtaztnen_7L49=
078QOP0s7QMz4TYLpUcRdnuRjLBTERwj4QR1IiU0s63ZriJQbj8GZuqi_UiYSFl-_nRDLr=
OE6uyAwrvC2RqiZSSC_3TkbWb5vwN_c8BfBbB5pMUZ3rC7QUJXqDGPxwUUafutdBfkAMNw=
jG4AAgSL4OFVNNOu6ckiExeXPWqI6B6j_aNiD2YDKtu7WBIfMSzp9NO62Ox18WGetR6MOe=
_QvXbj10geldvpAsvmP347ZBQNu6r7UEw2"><FONT=20
color=3D#0563c1><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN><B>Moni=
toring and=20
Evaluation for Food Security and Nutrition Course Workshop Dec 06 to D=
ec=20
17,2021<o:p></o:p></B></FONT></A></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><B>&nbsp;<o:p></o:p></B></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3Dsbc4DTMkZHc2mqY=
uhmtz6NW15QVc99TzA2KiCswGB4QqokCjYurLYAeHqG-1xQh1GC4CJ1fZm7zFJxeDYovsP=
LM70Qtlc0I_8msBuxSgVUtacfgZdNAE7QTbO1HZgADRl40yiFmi5odAe93rPKpDStIw4N-=
P4ESy02zeFnSc7sE6eX-vMN-9LZGdvDVZdVKWL0YWVMVfaUUjMXKW7gF3hi3bOq61b4KTj=
dPkfULwV4ZuimuMA1R38lK6tuVhtexk1Uvc1KCXqbYVLrkJ0XTFfUD5f56A3_RPmMAcrUR=
5rlHM0"=20
target=3D_blank><FONT color=3D#0563c1>Register onsite attendance=20
workshop<o:p></o:p></FONT></A></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DhlAh07IDE5TeHJw=
hvVyZrkd4UYkqUbcT1eaTLd6hrmZ60NQk863oJsyb66X8XupkS12utDuDSZdyKYhHpJvz5=
ksp1HtQO-JTYF50Vg8k65fxEl3FkE3tfZz7Biomz653_ifJPl0rQvDXxlL2runHpvbHeu9=
rxkj2uHGgZ0KAn1KX1TNP9Z9isCE7I7Xeb71d_PJ8NpVmCyDyBN61UsAiw48M0tlfUrU7x=
lkPi5o4XW7qLPcF3e5aKzK88YMnX6hkIL0BEjWVPcA6zJ8nvbYTfNatjeGDV6z_NF2wLqX=
srwi0ibGGUYEcONvfWOXcTzwnDw2"=20
target=3D_blank><FONT color=3D#0563c1>Register for online attendance=20
Workshop</FONT></A><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DHZJSNiRlhC3AZSh=
HLsn5PTPoRF51BKYV913R9ZdL7K5xEmfdRl3Xa9DhvlbFGe5XQS85u1rPCB3sGFsUKyhjq=
Qx-4YcpWrOQRk0lCdoWMDvCCJJ8fESe3pKozQZNrwy_3g2ajPKH3cLMCKiJKd6ZRen_ZGg=
pjwmg9cw6mAQh7O0PDqQy7fwXVGpOUvqdJtxeJKl8QrAKAcWokGj_-9i_qTeU7frdlI35I=
Oy2Hj5ttcUaVCgQYfumG2IifX83Lvmpop8bfaAWswKbF0Hh4TrFsJoI6rPVKcz2o3ilgjj=
1ltbt0"><FONT=20
color=3D#0563c1>Group Registration Here<o:p></o:p></FONT></A></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DsreBwoDzYdgj3bO=
aBCRBsUjfBl7INs8m6G7880FO93iPm6YcioMVihbGt5g9wvp7pwvppmSraB0le_0SAPU5q=
oSTyUXaI3sgaIm4YppdQzMp10o1Faeg3zCvTSkXM-Rj9uD588mQC-gf9STMtZZZ8WlF9no=
arg65QQXomaoy8cOT0" target=3D_blank><FONT=20
color=3D#0563c1>Download PDF Calendar 2021-2022=20
Workshops</FONT></A><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"mailto:training@fdc-k.org?subject=3DRE: Inquiring on"><STRONG>=
Send us=20
Email</STRONG></A><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DIuDb5fT4fapGEpK=
DebKZ5rH8926BKl9IxGb1W-mC0hKTsF20jIllr-sH9-wVb-Dj6yIiiDHx6Xmjvdl-VJkbh=
oFRrTt6AHRrIcSNEV4Ued0gHI-JFjrlQi1Bxzega152OHp0U7ORydEACiDJBB_NAOA1"><=
FONT color=3D#0563c1>Contact=20
us</FONT></A><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DRAnyf8LX2fAhmeu=
RPJDlDCfWxLbWUcM9cR20ZA1NmmocLrewIZF-tQlE9jWAUF1X-dYby72Csc412ffsTM77Q=
qeUpBrUz2YXhaxmDHr4FYZTSEOufmDBkauPh4gWmIHGp_LJkbO37vMoPRmH5raHp9I1"><=
FONT=20
color=3D#0563c1>Whatapp</FONT></A><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>VENUE:=20
HILTON HOTEL, NAIROBI KENYA<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt; TEXT-INDENT: 3pt"><=
SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpFirst=20
style=3D"MARGIN: 0cm 0cm 0pt 36pt; TEXT-INDENT: -18pt; mso-list: l5 le=
vel1 lfo4; mso-add-space: auto"><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Symbol; LINE-HEIGHT: 107%; mso-=
fareast-font-family: Symbol; mso-bidi-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>OFFICIAL=20
EMAIL ADDRESS:&nbsp;<A>training@fdc-k.org</A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"MARGIN: 0cm 0cm 0pt 36pt; TEXT-INDENT: -18pt; mso-list: l5 le=
vel1 lfo4; mso-add-space: auto"><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Symbol; LINE-HEIGHT: 107%; mso-=
fareast-font-family: Symbol; mso-bidi-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>Office=20
Telephone: +254712260031<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpMiddle=20
style=3D"MARGIN: 0cm 0cm 0pt 36pt; TEXT-INDENT: -18pt; mso-list: l5 le=
vel1 lfo4; mso-add-space: auto"><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Symbol; LINE-HEIGHT: 107%; mso-=
fareast-font-family: Symbol; mso-bidi-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DbnYtkUNPi3sGQxd=
Qx7_-J895eVCORmqUqi4ZkWksLi515-ivqT8R4wzIhysRZ1lY3-mX4V5FXbZZkx-LEgzN8=
KKXJpAQfsJYE6CSHSAcEDb04hQNwmjHSQRygPk69svVpu8nzBAPGagfI5h8ijSgmBizGDG=
Vbi_LVkKCOecZRHAH0"><FONT=20
color=3D#0563c1>Our 2021 - 2022 Professional Short Training=20
Courses</FONT></A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraphCxSpLast=20
style=3D"MARGIN: 0cm 0cm 0pt 36pt; TEXT-INDENT: -18pt; mso-list: l5 le=
vel1 lfo4; mso-add-space: auto"><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: Symbol; LINE-HEIGHT: 107%; mso-=
fareast-font-family: Symbol; mso-bidi-font-family: Symbol"><SPAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>Register=20
as a group of 5 or more participants and get 20% discount on course fe=
e. Send us=20
email to training@fdc-k.org or call +254712260031<o:p></o:p></SPAN></P=
>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 15pt; LINE-HEIGHT: 16.9p=
t"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'>Introduction</SPAN=
></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 15pt; LINE-HEIGHT: 16.9p=
t"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'>In=20
order to achieve a world free of hunger and malnutrition, it is vital =
to provide=20
sustainable solutions that provide the largest impacts on development =
outcomes.=20
Monitoring and Evaluation tools and techniques plays a key role in ens=
uring Food=20
Security programs are designed, implemented as plan and that they impr=
ove the=20
well-being of the target communities. This course equips the participa=
nts with=20
adequate skills to develop and manage robust M&amp;E systems for effec=
tive=20
management of FSN programs. The learner is introduced to FSN indicator=
s, tools=20
and techniques for M&amp;E in FSN.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'>&nbsp;<o:p></o:p><=
/SPAN></P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Who=20
Should Attend?</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'>This=20
is a general training is targeting variety of programme staff, managem=
ent team=20
members and thematic staff, Project Management Officials, government o=
fficials,=20
programme managers;&nbsp;policy makers and programme=20
implementers;&nbsp;development practitioners and activists and NGO and=
 CSO=20
members, &nbsp;Research organizations among others for Agriculture sup=
port=20
activities.&nbsp;&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>&nbsp;</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>No=20
of Days</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'>10=20
days<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>&nbsp;</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Course=20
Objectives</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 16.9pt; mso=
-list: l11 level1 lfo5; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Gain=20
  skills in both qualitative and quantitate data collection and analys=
is in=20
  M&amp;E for food security and nutrition programs.<o:p></o:p></SPAN><=
/LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 16.9pt; mso=
-list: l11 level1 lfo5; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Strengthen=20
  their competence in the designing, monitoring, and evaluation of FSN=
=20
  programs.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 16.9pt; mso=
-list: l11 level1 lfo5; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Gain=20
  insight into the principles of monitoring, evaluation and impact ass=
essment in=20
  food and nutrition security.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 16.9pt; mso=
-list: l11 level1 lfo5; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Appreciate=20
  the need to integrate gender role in the development of FSN=20
  programs.<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 16.9pt; mso=
-list: l11 level1 lfo5; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Come=20
  up with clear ideas for improving monitoring, evaluation and impact=20
  assessments for food security and nutrition=20
programs.<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 12pt 0cm 0pt; LINE-HEIGHT: =
16.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Course=20
Content</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
1:&nbsp;Fundamentals of Monitoring and Evaluation</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l3 level1 lfo6; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>What=20
  is M&amp;E?<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l3 level1 lfo6; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Significance=20
  of M&amp;E<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l3 level1 lfo6; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Principles=20
  and concepts in M&amp;E<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l3 level1 lfo6; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>M&amp;E=20
  and the project lifecycle<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l3 level1 lfo6; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Complementary=20
  roles of monitoring and evaluation<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
2: Food Security and Nutrition M&amp;E Frameworks</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l13 level1 lfo7; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Food=20
  security and nutrition conceptual frameworks<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l13 level1 lfo7; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Food=20
  security and nutrition results frameworks<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l13 level1 lfo7; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Logical=20
  framework analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l13 level1 lfo7; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Food=20
  security and nutrition projects design using=20
LogFrames<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
3: Food Security and Nutrition Indicators</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l16 level1 lfo8; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Food=20
  security and nutrition indicators<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l16 level1 lfo8; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Indicator=20
  metrics<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l16 level1 lfo8; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Link=20
  between indicators and &nbsp;results<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l16 level1 lfo8; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Indicator=20
  Matrix<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l16 level1 lfo8; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>FSN=20
  indicator performance tracking<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
4: M&amp;E System design and M&amp;E Planning in FSN</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l4 level1 lfo9; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Importance=20
  of an M&amp;E Plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l4 level1 lfo9; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Components=20
  of an M&amp;E Plan<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l4 level1 lfo9; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Design=20
  Principles for monitoring and evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l4 level1 lfo9; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Using=20
  M&amp;E plan to implement M&amp;E in a project<o:p></o:p></SPAN></LI=
>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l4 level1 lfo9; tab-stops: list 36.0pt; mso-margin-top-alt: aut=
o; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>M&amp;E=20
  plan against performance management plan<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
5: M&amp;E Considerations for Sector Specific Programming</SPAN></B><S=
PAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l6 level1 lfo10; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Food=20
  availability<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l6 level1 lfo10; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Food=20
  access<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l6 level1 lfo10; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Food=20
  utilization<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l6 level1 lfo10; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Stability<o:p></o:p></SPAN></L=
I>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l6 level1 lfo10; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Market=20
  Information<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
6: M&amp;E Considerations for Health and Nutrition&nbsp;</SPAN></B><SP=
AN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l9 level1 lfo11; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Selection=20
  of indicators<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l9 level1 lfo11; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Integrated=20
  disease surveillance and nutrition surveillance systems<o:p></o:p></=
SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l9 level1 lfo11; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Nutrition<o:p></o:p></SPAN></L=
I></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
7: Data Management for M&amp;E in FSN</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l0 level1 lfo12; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Sources=20
  of M&amp;E data<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l0 level1 lfo12; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Qualitative=20
  data collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l0 level1 lfo12; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Quantitative=20
  data collection methods<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l0 level1 lfo12; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Participatory=20
  methods of data collection<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
8:&nbsp;Data Analysis with SPSS/STATA/R or <SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>Python</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l10 level1 lfo13; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Data=20
  cleaning<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l10 level1 lfo13; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Qualitative=20
  data analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l10 level1 lfo13; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Quantitative=20
  data analysis<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l10 level1 lfo13; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Data=20
  interpretation and reporting<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
9: Gender consideration in M&amp;E for FSN</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l7 level1 lfo14; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Gender=20
  integration during project activities design<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l7 level1 lfo14; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Gender=20
  indicators in food security and nutrition programs<o:p></o:p></SPAN>=
</LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l7 level1 lfo14; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Cross-cutting=20
  gender issues in FSN<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l7 level1 lfo14; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Role=20
  of M&amp;E in addressing gender<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l7 level1 lfo14; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Measure=20
  of gender outcomes<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
10: Evaluation of Food Security and Nutrition Programs</SPAN></B><SPAN=
=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l15 level1 lfo15; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Determining=20
  evaluation points from results framework<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l15 level1 lfo15; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Components=20
  of evaluations, implementation and process evaluations<o:p></o:p></S=
PAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l15 level1 lfo15; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Evaluation=20
  designs<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l15 level1 lfo15; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Performance=20
  evaluation process<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l15 level1 lfo15; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Evaluation=20
  findings, sharing, and dissemination<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
11: Impact Assessment of FSN Programs</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l1 level1 lfo16; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Introduction=20
  to impact evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l1 level1 lfo16; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Impact=20
  assessment in program design<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l1 level1 lfo16; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Attribution=20
  in impact evaluation<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l1 level1 lfo16; tab-stops: list 36.0pt; mso-margin-top-alt: au=
to; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Impact=20
  evaluation methods<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal=20
style=3D"VERTICAL-ALIGN: baseline; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 1=
6.9pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; BORDER-TOP: windowtext 1pt; FONT-FAMILY: "Ti=
mes New Roman",serif; BORDER-RIGHT: windowtext 1pt; BORDER-BOTTOM: win=
dowtext 1pt; COLOR: black; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: windowtext 1pt; PADDING-RIGHT: 0cm; mso-fa=
reast-font-family: "Times New Roman"; mso-border-alt: none windowtext =
0cm'>Module=20
12: M&amp;E Results Use and Dissemination</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; COLOR:=
 black; mso-fareast-font-family: "Times New Roman"'><o:p></o:p></SPAN>=
</P>
<UL type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l12 level1 lfo17; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Use=20
  of M&amp;E results to improve and strengthen FSN=20
  projects<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l12 level1 lfo17; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Use=20
  of M&amp;E Lessons learned and best practices<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l12 level1 lfo17; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>M&amp;E=20
  reporting<o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"COLOR: black; MARGIN: 0cm 0cm 8pt; LINE-HEIGHT: 16.9pt; mso=
-list: l12 level1 lfo17; tab-stops: list 36.0pt; mso-margin-top-alt: a=
uto; mso-margin-bottom-alt: auto"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; mso-=
fareast-font-family: "Times New Roman"'>Design,=20
  monitoring, and evaluation of resilience=20
interventions<o:p></o:p></SPAN></LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><BR><BR>&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>General Notes</SPAN></B><SPAN=
=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p></o:p></SPAN></P>
<UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>All=20
  our courses can be Tailor-made to participants needs <o:p></o:p></SP=
AN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>The=20
  participant must be conversant with English <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>Presentations=20
  are well guided, practical exercise, web based tutorials and group w=
ork. Our=20
  facilitators are expert with more than 10years of experience.=20
  <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>Upon=20
  completion of training the participant will be issued with Foscore d=
evelopment=20
  center certificate (FDC-K) <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>Training=20
  will be done at Foscore development center (FDC-K) center in Nairobi=
 Kenya. We=20
  also offer more than five participants training at requested locatio=
n within=20
  Kenya, more than ten participant within east Africa and more than tw=
enty=20
  participant all over the world. <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>Course=20
  duration is flexible and the contents can be modified to fit any num=
ber of=20
  days. <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>The=20
  course fee includes facilitation training materials, 2 coffee breaks=
, buffet=20
  lunch and a Certificate of successful completion of Training. Partic=
ipants=20
  will be responsible for their own travel expenses and arrangements, =
airport=20
  transfers, visa application dinners, health/accident insurance and o=
ther=20
  personal expenses. <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>Accommodation,=20
  pickup, freight booking and Visa processing arrangement, are done on=
 request,=20
  at discounted prices. <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>One=20
  year free Consultation and Coaching provided after the course.=20
  <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>Register=20
  as a group of more than two and enjoy discount of (10% to 50%) plus =
free five=20
  hour adventure drive to the National game park. <o:p></o:p></SPAN></=
LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>Payment=20
  should be done two week before commence of the training, to FOSCORE=20
  DEVELOPMENT CENTER account, so as to enable us prepare better for yo=
u.=20
  <o:p></o:p></SPAN></LI>
  <LI class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt; mso-list: l2 level1 lfo1; tab-stops: l=
ist 36.0pt"><SPAN=20
  style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE=
-HEIGHT: 107%'>For=20
  any enquiry to:training@fdc-k.org or +254712260031<o:p></o:p></SPAN>=
</LI></UL>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>OTHER=20
UPCOMING WORKSHOPS FOR &nbsp;DEC <SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>2021 ( CLICK LINK TO REGISTER=
 FOR THE=20
WORKSHOP AS INDIVIDUAL OR GROUP)<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P>
<TABLE class=3DMsoNormalTable=20
style=3D"WIDTH: 807.35pt; BORDER-COLLAPSE: collapse; mso-yfti-tbllook:=
 1184; mso-padding-alt: 0cm 0cm 0cm 0cm"=20
cellSpacing=3D0 cellPadding=3D0 border=3D0>
  <TBODY>
  <TR style=3D"mso-yfti-irow: 0; mso-yfti-firstrow: yes; mso-yfti-last=
row: yes">
    <TD=20
    style=3D"BORDER-TOP: #f0f0f0; BORDER-RIGHT: #f0f0f0; WIDTH: 531pt;=
 BORDER-BOTTOM: #f0f0f0; PADDING-BOTTOM: 0cm; PADDING-TOP: 0cm; PADDIN=
G-LEFT: 0cm; BORDER-LEFT: #f0f0f0; PADDING-RIGHT: 0cm; BACKGROUND-COLO=
R: transparent"=20
    vAlign=3Dbottom width=3D1076>
      <UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DrW7kv9a=
e3RIZGNLEJPAmbGoIzbaxWOgeKodQ2pqAUJT9fGGmY7BWJInJeB0aQZDX5dq5C3IOc4apl=
KwS7L0Fv3Gj8NP02mLjhi1Lso5zU7X_dAGr5btpLbASaFwRy9rre8iHQp5JNVVUmCxIbiu=
zvxjRhbGeBIutfn8XWGc_2IHeVd1v-8Li1QiIJyfLyyo8sOOhzYBaJFQCdwdKjWu935nlk=
xV1hOjLVuSR4crM9rhG43oH3kdj6I_YvMcyt_idsg2"><FONT=20
        color=3D#0563c1>Project Proposal and Report Writing skill=20
        Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DQOZNMWv=
zoXnMKI2fGh5nabRYQrpew_x9UD9wJ5votMFW8vy1OinT5WG51tfw9FaSSIhaDeX9RbOLG=
hMEDXHAui9e8VBUydpifI04rrbXD_9xeMB3QeR1yoSqVJmJPikQHkgLbS9Iwig1Xv5DO6j=
zf3xqbwGDyIeHT-Q_g_hOpNYRgbsnEQ-cuBnic_rSJ13MBLNzuyQbZkEVIaMLVvtVbTzi8=
l2eVVtBy-tfa7TFPjUo0"><FONT=20
        color=3D#0563c1>GIS Application in Disaster Risk Reduction=20
        Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DnOc8Q6-=
GnKVUIpgRPHvuCLjOnOA5sYtPFl7i9-F3bH496DMfAOmuYtM8pSO0FYfcCDky-VdlTj2ow=
6KNimuJugdKo0xoUb6Ha7BeDOyPVmgmnhqRTLul4qceMMuwtdv9doMzMHu6grBe_IrmjoQ=
MEy0x9XQzPkgP0CHO8FXMHKErtPrRME-6PlZoNKRqlpg-IAgHwrPtAwAf84YrwSpqGAnTC=
VRkrpCAu5R4U51XtVnPASY0ET9ZT558DXQ9L_sKyPVykWhWFLFGO6qM1LHcdyk1"><FONT=
=20
        color=3D#0563c1>GIS and Data Analysis for WASH (Water Sanitati=
on and=20
        Hygiene) Programmes Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DsS__0er=
epjGz7nNWLKoO-AhpJA3E-K_ZOh7tziK_e7TwHTAm1eGBFelJeni-Qq1Ez41uz7ideI_sa=
qFHVXldLmVzIMyVYHsUH0QOOswCpO1VcbCxAJaKkSomf_zi3NzGzp2dOVaLHs6H9IQso9O=
Z-DL_iYnszJEf1rtVSVcHAjpB51Lwx-oQn4p6w9AOInsO9SqbGw__u5Z2OgqKKhjtYCtNW=
23eMwLk461wIUsh-S4D0"><FONT=20
        color=3D#0563c1>Grant Management and Fundraising=20
        Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DH0J4oi_=
ev6a97xOQ5Y-4mK4Yu55YW4VLhFjyzsuXclfR0uZZAEJkrq2g3QodoOm3h6pb1okIKrrkf=
kKNsAE7cl3_kGBZF4W12-FgypLASq8i5dxQKMjATxJ1rZ3FOYWl-jZQ7To83qGZeIaeOAy=
988JI3dcsaacDQMdfFBwDo9Od75KSS2R7GgNheH_JdQ5C-XMt8T3okZusI7wWw4dpR1ocv=
LaVwCbRnS3RG_cmrk89E86EmIsFum89_ZyK29X2zw2"><FONT=20
        color=3D#0563c1>Human Resources Management and Development=20
        Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3Dt34mSR_=
-JO2cYF8soJwxFU229DKJaQtqDcCJBXmXP6uFspqzohg82w2hLKg_jakGw5-YTyjh0qU8V=
EaXBvkUte2rl5gOEIWirTMTjnrsJi2dO1gL2eyBiPCrxB-tgBaksGDQpa3wErxs9MNoL4g=
zSuapoA1p4S_wkVhg8JC0zC_06L4ARpXXXRCHA5t3AD_DVkVWXthe6Vr29E2CJbKLI6p_d=
WhVtj6jps3q-8B4EAYzmdh989T51Yj8mMVUy5Tksw2"><FONT=20
        color=3D#0563c1>Account Management and Business Development=20
        Workshop</FONT></A> </SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DhyFMwvq=
lwCr3FCPaSjAggxoHrayjit8aHsCNns_bX1AGdznixN5HXcugstw2qtfPW3E6kVUoFW7Gd=
2OrqVOifIIaoOBUsvopiNcCuVQbj31V6GU8oQIB4DYgDIn4rc1S3IYFIoGCxdA27YDN4hv=
ks11ginYzEz8_zGUtd-DmfNcfPeDBHawLa8slz7iSKl59RgLTjkNW21fMtnBkHB9nzXMUf=
DsGMJ7EGpq2Qu7L3RuDkKJFprreX7imWOsDhWt3NO_dobKlikAPX8GsODqLDj41"><FONT=
=20
        color=3D#0563c1>Advanced Monitoring and Evaluation for Develop=
ment Results=20
        Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DFZZ3aPi=
Ka1myz1TMyCycKD1YIkh0RjZBzkQsf2ll4PVxl5UYCNL7IgDT59Dg_QeiMLd024kKzBNfW=
lwgQuaNXtaP_EdnpNqgq0sTWXt3UBkgTxL1UPp7EWL46tmfxC0rQb3BrJDRDdb3SHjMjQ1=
1iQKQYfGEtiXXVOEpTh3sADxgk9tkcnAhT12Re2TEOJpg3cPqlvTpeD3VDHq5gmZ5Y2S28=
5GBRJG2SrZiFeb6QirVx4iKAWHrOZ4n6aA52QyApg2"><FONT=20
        color=3D#0563c1>Executive Leadership &amp; Management Program=20
        Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DH0J4oi_=
ev6a97xOQ5Y-4mK4Yu55YW4VLhFjyzsuXcldIkSUL24jFdhKp79ePdMS3LhN8gBaijrmB0=
BkTYxHkhI6VUFWxclg-OoMGIRR3T6yCDW1uPa5xWvP17SPDaPRFVjf7f-P2TCmR3e9L1MA=
junKxsmm_WW21oq95n5uiFA5kvosjvqNhZtWBBJBZmIRksalH0l7r8IMbpQqz1LDzgczW4=
LMuf6H5mat-pgo_thqS3NoHAf168_cH-y1vOfICkQ2"><FONT=20
        color=3D#0563c1>Procurement logistics and Supply Chain Managem=
ent=20
        Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; BACKGROUND: white; COLOR: black; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DhyFMwvq=
lwCr3FCPaSjAggxoHrayjit8aHsCNns_bX1AGdznixN5HXcugstw2qtfPW3E6kVUoFW7Gd=
2OrqVOifIIaoOBUsvopiNcCuVQbj31V6GU8oQIB4DYgDIn4rc1S3IYFIoGCxdA27YDN4hv=
ks11ginYzEz8_zGUtd-DmfNcfPeDBHawLa8slz7iSKl59QT7dUzyz2Oh25QeO1sj_MBCqQ=
Bfa9Xzf9vL2qZJ-XDhosSs6ijXlr5ffNtsvmePbMpsiy8cSlH5_GSvdcbBQr0w1"><FONT=
=20
        color=3D#0563c1>Advanced Monitoring and Evaluation for Develop=
ment Results=20
        Workshop</FONT></A></SPAN><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l8 =
level1 lfo2; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3D_mXZj3f=
WRGoOlS7RLh7BrmdvnSNLcaNEqgj-vjFylHl89TmFexoB8kkr6Nfsh3xBnSyU7-bugqJuT=
fIhj-YMmzXeRZJRTodwbsnc2NmZTOQka2_GgwBUtUAbZDcXzen5M-BLnogSRwMmTCPgqRO=
9XzE637GSidkck4ixNqS4mWaftk8MvSomFCEKBLar5OHWV7qTfEMpZZsVdFbLaBI7gK5ra=
8-LzoRJWW9LAQANkGvu8oGJe3MRVijdSO99fUZt3-Kha3E2tdaK4C1WgUq5JETugHQOOuU=
oNJS9Lefp4x2QCuxwSp7kDXx8-U9BK9fvZg2"><FONT=20
        color=3D#0563c1>Research Design, ODK Mobile Data Collection, G=
IS Mapping,=20
        Data Analysis using NVIVO and SPSS=20
        Workshop</FONT></A><o:p></o:p></SPAN></LI></UL>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
      style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; =
LINE-HEIGHT: 107%'><A=20
      href=3D"mailto:training@fdc-k.org?subject=3DRE: Inquiring on"><S=
TRONG>Send us=20
      Email</STRONG></A><o:p></o:p></SPAN></P>
      <P class=3DMsoNormal=20
      style=3D"MARGIN: 0cm 0cm 0pt 36pt; LINE-HEIGHT: 200%"><SPAN=20
      style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; =
LINE-HEIGHT: 200%'><o:p>&nbsp;</o:p></SPAN></P>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><B=20
      style=3D"mso-bidi-font-weight: normal"><U><SPAN=20
      style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; =
LINE-HEIGHT: 107%'>Course=20
      Programme<o:p></o:p></SPAN></U></B></P>
      <UL style=3D"MARGIN-TOP: 0cm" type=3Ddisc>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DT6lCy8p=
p7qaQm2svsW0RO0lSdL1kal9oK_8RHk20A0ymGqmha3raDzP7oOIzWPPWm50TMJmRpiRkf=
L_2YceJNACWfWt8ETxeMvnMqLhcUSh5qDvGEencAGpFn5pL4jSpHpPzv7UM5bdWGdVg5Ps=
SkxLxwRUyfg26bqP7I4BSEvnJ0"><FONT=20
        color=3D#0563c1>Research and Data Analysis professional short=20
        courses</FONT></A> <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DoIYlemS=
3tkyJdnMqFtgDsNXW7P4RVXGA9QAqVX1zHLhJ6VP88pVbh6iUK0yjcbD37caydPYKgbeNG=
OBWw_7TxZLUwMarFu9XcxFTB6aQTfx09Th144kRg2TqmxPjSqRXps-eQVBtNGyrwJXCipl=
aSfcQqZ1gwx6XDPAGC69VzzPb0"><FONT=20
        color=3D#0563c1>Monitoring and Evaluation professional short=20
        courses</FONT></A> <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DDUk_5cu=
brG4VzOFxNOrgJFlnltkJvfd5lAT4R1jlj_mLo6Zy2K2-xxWjl0A7tGRNYg7WkJPzQ4rYO=
LrMK4gSTnkuxQdBONNBR05lwZ8FGE_vWoc7LTJZzCeohu7OsQWRUbJXoDDX4xkrL1Pphyg=
gI6R5qxRS8iEnA1S8NkehcJJu0"><FONT=20
        color=3D#0563c1>Humanitarian and Social Development profession=
al short=20
        courses</FONT></A> <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3D-buLjbM=
9L6KOre4C8hUPHdNnwolCZyUr0IHu7cRyJSPiq8bOXUnm_76xaiJy4raRvVzPV3AcVGnyg=
fKyeb1nvRp_GtO2cGPdxxtAEvm2O1JB4xGoy0f6wOL4M8_zAe0e3SeGeT5yxOhe24HVN0r=
N-G4x7LmIJQyQbrwC916Dlc1V0"><FONT=20
        color=3D#0563c1>Information Technology professional short=20
        courses</FONT></A> <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3Dz90kp3X=
jIiyQkZQKKUR-lIDZcCdAv-SZVv9wIYNoMnpFBiE-TiS-VcszFuRfrdhMrLZhW2BrADFuZ=
GCNj4kKsJWx-e2j4Nuzw_dqPGEdc-JTY_xeAlNTrGamj11lNOd5L-0WPYaf4KjsXOdXlqr=
wTCk1"><FONT=20
        color=3D#0563c1>Agriculture professional short courses</FONT><=
/A>=20
        <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3D5ryvc8T=
sQ85hwqyejsKXKVDndgedV2SNbSwhSI5lqjZX3BSas_XHmJzJSyTZgHudDmFE49sLS6N3B=
XX3S3nMwv4MMH4vWltHZ81itvVP4yvv_iYu16e79CTwQgOW7JJWbyM5p0sMAMLiJkihtiM=
8b_M1"><FONT color=3D#0563c1>GIS &amp;=20
        Remote Sensing professional short courses</FONT></A>=20
        <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DbnYtkUN=
Pi3sGQxdQx7_-J895eVCORmqUqi4ZkWksLi515-ivqT8R4wzIhysRZ1lY3-mX4V5FXbZZk=
x-LEgzN8D01i4fqS20H0nWYJu1NobLZg6DLV_8KVgy9YUZ_w407B1x_FWIqzOEcCAhaRXs=
SBe7kSUTZXOOkQ9McN6yN8Tf40"><FONT=20
        color=3D#0563c1>Business and Governance professional short=20
        courses</FONT></A> <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DDKnHJQ8=
9IuYKhFmUtePTFx8tQylcbKS2dpw4-xXiDgLNL3_jSuZfUvRdQnQ-xkpt6jlYhHUJp4aMB=
AQljupvQMqXoGpLGh--rxjhObicijKiQHcPnePlb1bFLBnT1keUvK9NxgwNWHb5zuOsx8s=
3el81"><FONT color=3D#0563c1>Choose your=20
        Online Training Course</FONT></A> <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DPnM6e6C=
oRnZ59pk4Vo6cYaucTZ2k8VUPuH_AFSsmkrtykZ4HV6hl2VM4ViL7n_1HtMTNIQQwKWVNH=
sCYp_NxnHwBGhXyvV-l085DY_E9usWVUxDurGt0gA_k1J8yilGwGUCb7hoBPaC1H6Eo315=
ABhg1"><FONT color=3D#0563c1>consultancy=20
        solutions</FONT></A> <o:p></o:p></SPAN></LI>
        <LI class=3DMsoNormal=20
        style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 200%; mso-list: l14=
 level1 lfo3; tab-stops: list 36.0pt"><SPAN=20
        style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif=
; LINE-HEIGHT: 200%'><A=20
        href=3D"http://tracking.fdc-k.or.ke/tracking/click?d=3DbnYtkUN=
Pi3sGQxdQx7_-J895eVCORmqUqi4ZkWksLi515-ivqT8R4wzIhysRZ1lY3-mX4V5FXbZZk=
x-LEgzN8K3dJjEXXzQz4Vy02wWvn-O6WGvax_p32vTW0VIQeSlsrcbpXn-7EBOXbDaNqEa=
umPALhm0i6WJXisQN9tzL6wiy0"><FONT=20
        color=3D#0563c1>Our 2021 - 2022 Professional Short Training=20
        Courses</FONT></A><o:p></o:p></SPAN></LI></UL>
      <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><B=20
      style=3D"mso-bidi-font-weight: normal"><U><SPAN=20
      style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; =
LINE-HEIGHT: 107%'><o:p><SPAN=20
      style=3D"TEXT-DECORATION: none">&nbsp;</SPAN></o:p></SPAN></U></=
B></P></TD></TR></TBODY></TABLE></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>Looking=20
forward to your &nbsp;attendance.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>FDC=20
Result Based skills Development<BR>Regards,<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>Training=20
Coordinator<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><BR>Telephone=20
office: +254712260031<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><A=20
href=3D"mailto:training@fdc-k.org?subject=3DRE: Inquiring on">Send us=20
Email</A><o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'>You=20
can opt out of future communications about our services by clicking on=
 the=20
unsubscribe link below.Thank you</SPAN></B><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Times New Roman",serif; LINE-H=
EIGHT: 107%'><o:p>&nbsp;</o:p></SPAN></P>
<P>&nbsp;</P></BODY></HTML>

<img src=3D"http://tracking.fdc-k.or.ke/tracking/open?msgid=3D82Tz160C=
ZjD0EHKSKtkLzg2&c=3D1452641685061462781" style=3D"width:1px;height:1px=
" alt=3D"" /><div style=3D"text-align:center; background-color:#fff;pa=
dding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sans-seri=
f;"><a href=3D"http://tracking.fdc-k.or.ke/tracking/unsubscribe?d=3DWo=
F2vKhVkWYD7P-CQaY09lzzveVcjwpzIWmH-7sQEns-90H9neZ69qaHyLVjdNxYRgAcZvAD=
1K16CDntIBqa8KBZaLQYMfVB89Fh1c4GsImd0" style=3D"text-align:center;text=
-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfXDDh5HSad+SkYO1/TAHq4S923tI/y3WKzQ==--
