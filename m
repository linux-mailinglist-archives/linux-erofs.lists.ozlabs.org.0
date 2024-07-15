Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDEE930EDF
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2024 09:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721028874;
	bh=jAkrdbEgX3n6wgSxNtfpFvrs44SSptds1NomayNmOi8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=J9ef6PQqgxMVAzEOfLJa+hHRO6CRIrI6vbPQjj/5GxIhWPtQX0wox1dIwGmOO+rM5
	 V77+jiRou5w0RDDXtpYYHXhaU8nq68RAm3n9i4XDE3aLNMHJhQihIqS35yyFuMtl4i
	 9pbzdU5vyQH0b7RlqYf3lAzx7iTKUAir4kqHWtY4TvOvTee2yvIiCDMAIhnQrGDUD8
	 hkYGP+hkV49BdHBTW0BHu/JrFgkVSCKP2txubaHGiiJIqwFSQurul1+KUPbYXof8SC
	 K9vqQmsc9+DNaIa77pw6zHY09e6GjsOMwLREU83ho//Ii1dz/Wgu7udIrFZzixf9bl
	 T+ixp6B93iEUQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WMv965mgWz3clx
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2024 17:34:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=118.143.206.90; helo=outboundhk.mxmail.xiaomi.com; envelope-from=xiaomiaosen@xiaomi.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Mon, 15 Jul 2024 17:34:31 AEST
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WMv932vK8z3c05
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jul 2024 17:34:31 +1000 (AEST)
X-CSE-ConnectionGUID: zegxN35YRVGknd1qBS/fIg==
X-CSE-MsgGUID: b7podtPCRBapSy3pMfwuTQ==
X-IronPort-AV: E=Sophos;i="6.09,209,1716220800"; 
   d="scan'208,217";a="90746665"
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Issue of erofs use zstd
Thread-Topic: Issue of erofs use zstd
Thread-Index: AQHa1ok6MCt3CZVf7k2MUCitVDDsfQ==
Date: Mon, 15 Jul 2024 07:33:05 +0000
Message-ID: <0a71474744854fcf967e99666e8eab38@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.88.13]
Content-Type: multipart/alternative;
	boundary="_000_0a71474744854fcf967e99666e8eab38xiaomicom_"
MIME-Version: 1.0
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
From: =?utf-8?b?6IKW5re85qOuIHZpYSBMaW51eC1lcm9mcw==?= <linux-erofs@lists.ozlabs.org>
Reply-To: =?gb2312?B?0KTttcmt?= <xiaomiaosen@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_0a71474744854fcf967e99666e8eab38xiaomicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgR2FvWGlhbmcsDQoNCg0KV2UganVzdCB1cGRhdGUgdGhlIGxhc3QgZXJvZnMgdmVyc2lvbiwg
YW5kIHdhbnQgdG8gdGVzdCB0aGUgenN0ZCBjb21wcmVzcyBmZWF0dXJlLg0KDQpCdXQgaXQgd2ls
bCB0aHJvdyBzb21lIGVycm9yIHdoZW4gdXNpbmcgdGhlIG1rZnMuZXJvZnMgbWFraW5nIHRoZSBu
ZXcgaW1hZ2UsIGNvdWxkIHlvdSBoZWxwIHRvIGNoZWNrPyB0aGFua3MhDQoNCg0KZXJyb3IgOg0K
DQptaUBtaS1IUC1Qcm9EZXNrLTY4MC1HNi1QQ0ktTWljcm90b3dlci1QQzp+L3hpYW9tcy9Qcm9q
ZWN0L2Vyb2ZzL3Rlc3QkIC9ob21lL21pL3hpYW9tcy9Qcm9qZWN0L2Vyb2ZzL3NvdXJjZWNvZGUv
ZXJvZnMtdXRpbHMvbWtmcy9ta2ZzLmVyb2ZzIC1senN0ZCAgc3JjZC5lcm9mcy5pbWcgc3JjZC8N
Ci9ob21lL21pL3hpYW9tcy9Qcm9qZWN0L2Vyb2ZzL3NvdXJjZWNvZGUvZXJvZnMtdXRpbHMvbWtm
cy9ta2ZzLmVyb2ZzOiBzeW1ib2wgbG9va3VwIGVycm9yOiAvaG9tZS9taS94aWFvbXMvUHJvamVj
dC9lcm9mcy9zb3VyY2Vjb2RlL2Vyb2ZzLXV0aWxzL21rZnMvbWtmcy5lcm9mczogdW5kZWZpbmVk
IHN5bWJvbDogWlNURF9jb21wcmVzczINCg0KDQoNCk15IFBDIGNvbXBpbGUgZW52aXJvbm1lbnQg
YXMgYmxldzoNCg0KTGludXggbWktSFAtUHJvRGVzay02ODAtRzYtUENJLU1pY3JvdG93ZXItUEMg
NS40LjAtMTUwLWdlbmVyaWMgIzE2N34xOC4wNC4xLVVidW50dSBTTVAgV2VkIE1heSAyNCAwMDo1
MTo0MiBVVEMgMjAyMyB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgNCg0KDQoqKiogWnN0
YW5kYXJkIENMSSAoNjQtYml0KSB2MS41LjYsIGJ5IFlhbm4gQ29sbGV0ICoqKg0KDQoNCm1pQG1p
LUhQLVByb0Rlc2stNjgwLUc2LVBDSS1NaWNyb3Rvd2VyLVBDOn4veGlhb21zL1Byb2plY3QvZXJv
ZnMvc291cmNlY29kZS9lcm9mcy11dGlscyQgLi9jb25maWd1cmUgLS13aXRoLWxpYnpzdGQNCmNo
ZWNraW5nIGZvciBhIEJTRC1jb21wYXRpYmxlIGluc3RhbGwuLi4gL3Vzci9iaW4vaW5zdGFsbCAt
Yw0KLi4uDQpjaGVja2luZyB6c3RkLmggdXNhYmlsaXR5Li4uIHllcw0KY2hlY2tpbmcgenN0ZC5o
IHByZXNlbmNlLi4uIHllcw0KY2hlY2tpbmcgZm9yIHpzdGQuaC4uLiB5ZXMNCmNoZWNraW5nIGZv
ciBaU1REX2NvbXByZXNzMiBpbiAtbHpzdGQuLi4geWVzDQpjaGVja2luZyB3aGV0aGVyIFpTVERf
Y29tcHJlc3MyIGlzIGRlY2xhcmVkLi4uIHllcw0KY2hlY2tpbmcgZm9yIFpTVERfZ2V0RnJhbWVD
b250ZW50U2l6ZS4uLiB5ZXMNCmNoZWNraW5nIHRoYXQgZ2VuZXJhdGVkIGZpbGVzIGFyZSBuZXdl
ciB0aGFuIGNvbmZpZ3VyZS4uLiBkb25lDQpjb25maWd1cmU6IGNyZWF0aW5nIC4vY29uZmlnLnN0
YXR1cw0KY29uZmlnLnN0YXR1czogY3JlYXRpbmcgTWFrZWZpbGUNCmNvbmZpZy5zdGF0dXM6IGNy
ZWF0aW5nIG1hbi9NYWtlZmlsZQ0KY29uZmlnLnN0YXR1czogY3JlYXRpbmcgbGliL01ha2VmaWxl
DQpjb25maWcuc3RhdHVzOiBjcmVhdGluZyBta2ZzL01ha2VmaWxlDQpjb25maWcuc3RhdHVzOiBj
cmVhdGluZyBkdW1wL01ha2VmaWxlDQpjb25maWcuc3RhdHVzOiBjcmVhdGluZyBmdXNlL01ha2Vm
aWxlDQpjb25maWcuc3RhdHVzOiBjcmVhdGluZyBmc2NrL01ha2VmaWxlDQpjb25maWcuc3RhdHVz
OiBjcmVhdGluZyBjb25maWcuaA0KY29uZmlnLnN0YXR1czogY29uZmlnLmggaXMgdW5jaGFuZ2Vk
DQpjb25maWcuc3RhdHVzOiBleGVjdXRpbmcgZGVwZmlsZXMgY29tbWFuZHMNCmNvbmZpZy5zdGF0
dXM6IGV4ZWN1dGluZyBsaWJ0b29sIGNvbW1hbmRzDQoNCm1pQG1pLUhQLVByb0Rlc2stNjgwLUc2
LVBDSS1NaWNyb3Rvd2VyLVBDOn4veGlhb21zL1Byb2plY3QvZXJvZnMvc291cmNlY29kZS9lcm9m
cy11dGlscyQgbWFrZQ0KbWFrZSAgYWxsLXJlY3Vyc2l2ZQ0KbWFrZVsxXTogvfjI68S/wryhsC9o
b21lL21pL3hpYW9tcy9Qcm9qZWN0L2Vyb2ZzL3NvdXJjZWNvZGUvZXJvZnMtdXRpbHOhsQ0KTWFr
aW5nIGFsbCBpbiBtYW4NCm1ha2VbMl06IL34yOvEv8K8obAvaG9tZS9taS94aWFvbXMvUHJvamVj
dC9lcm9mcy9zb3VyY2Vjb2RlL2Vyb2ZzLXV0aWxzL21hbqGxDQptYWtlWzJdOiC21KGwYWxsobHO
3tDo1/bIzrrOysKhow0KbWFrZVsyXTogwOu/qsS/wryhsC9ob21lL21pL3hpYW9tcy9Qcm9qZWN0
L2Vyb2ZzL3NvdXJjZWNvZGUvZXJvZnMtdXRpbHMvbWFuobENCk1ha2luZyBhbGwgaW4gbGliDQpt
YWtlWzJdOiC9+MjrxL/CvKGwL2hvbWUvbWkveGlhb21zL1Byb2plY3QvZXJvZnMvc291cmNlY29k
ZS9lcm9mcy11dGlscy9saWKhsQ0KbWFrZVsyXTogttShsGFsbKGxzt7Q6Nf2yM66zsrCoaMNCm1h
a2VbMl06IMDrv6rEv8K8obAvaG9tZS9taS94aWFvbXMvUHJvamVjdC9lcm9mcy9zb3VyY2Vjb2Rl
L2Vyb2ZzLXV0aWxzL2xpYqGxDQpNYWtpbmcgYWxsIGluIG1rZnMNCm1ha2VbMl06IL34yOvEv8K8
obAvaG9tZS9taS94aWFvbXMvUHJvamVjdC9lcm9mcy9zb3VyY2Vjb2RlL2Vyb2ZzLXV0aWxzL21r
ZnOhsQ0KL2Jpbi9zaCAuLi9saWJ0b29sICAtLXRhZz1DQyAgIC0tbW9kZT1saW5rIGdjYyAtV2Fs
bCAtSS4uL2luY2x1ZGUgLWcgLU8yIC1EX0xBUkdFRklMRV9TT1VSQ0UgLURfRklMRV9PRkZTRVRf
QklUUz02NCAgIC1vIG1rZnMuZXJvZnMgbWtmc19lcm9mcy1tYWluLm8gLi4vbGliL2xpYmVyb2Zz
LmxhICAtbHV1aWQgLWxsejQgIC1seiAgLUwvdXNyL2xvY2FsL2xpYiAtbHpzdGQNCmxpYnRvb2w6
IGxpbms6IGdjYyAtV2FsbCAtSS4uL2luY2x1ZGUgLWcgLU8yIC1EX0xBUkdFRklMRV9TT1VSQ0Ug
LURfRklMRV9PRkZTRVRfQklUUz02NCAtbyBta2ZzLmVyb2ZzIG1rZnNfZXJvZnMtbWFpbi5vICAu
Li9saWIvLmxpYnMvbGliZXJvZnMuYSAtbHV1aWQgLWxsejQgLWx6IC1ML3Vzci9sb2NhbC9saWIg
LWx6c3RkDQptYWtlWzJdOiDA67+qxL/CvKGwL2hvbWUvbWkveGlhb21zL1Byb2plY3QvZXJvZnMv
c291cmNlY29kZS9lcm9mcy11dGlscy9ta2ZzobENCg0KDQoNCg0KDQojLyoqKioqKrG+08q8/ryw
xuS4vbz+uqzT0NChw9e5q8u+tcSxo8Pc0MXPoqOsvfbP3tPat6LLzbj4yc/D5rXY1rfW0MHQs/a1
xLj2yMu78si61+mho7371rnIzrrOxuTL+8jL0tTIzrrO0M7Kvcq508OjqLD8wKi1q7K7z97T2sir
sr+78rK/t9a12NC5wrahori01sahorvyyaK3oqOpsb7Tyrz+1tC1xNDFz6Kho8jnufvE+rTtytXB
y7G+08q8/qOsx+vE+sGivLS157uwu/LTyrz+zajWqreivP7Iy7Kiyb6z/bG+08q8/qOhIFRoaXMg
ZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRp
b24gZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3Ig
ZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZv
cm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBs
aW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3Ig
ZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3Is
IHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBh
bmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=

--_000_0a71474744854fcf967e99666e8eab38xiaomicom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi GaoXiang,</p>
<p><span style=3D"font-size: 12pt;"><br>
</span></p>
<p><span style=3D"font-size: 12pt;">We just update the last erofs version, =
and want to test the zstd compress feature.</span><br>
</p>
<p>But it will throw some error when using the mkfs.erofs making the new im=
age, could you help to check? thanks!</p>
<p><br>
</p>
<p>error :</p>
<p></p>
<div>mi@mi-HP-ProDesk-680-G6-PCI-Microtower-PC:~/xiaoms/Project/erofs/test$=
 /home/mi/xiaoms/Project/erofs/sourcecode/erofs-utils/mkfs/<b>mkfs.erofs -l=
zstd&nbsp; srcd.erofs.img srcd/</b></div>
<div><span style=3D"background-color: rgb(255, 255, 0);">/home/mi/xiaoms/Pr=
oject/erofs/sourcecode/erofs-utils/mkfs/mkfs.erofs: symbol lookup error: /h=
ome/mi/xiaoms/Project/erofs/sourcecode/erofs-utils/mkfs/</span><span style=
=3D"color: rgb(255, 0, 0);"><b><span style=3D"background-color: rgb(255, 25=
5, 0);">mkfs.erofs:
 undefined symbol: ZSTD_compress2</span></b></span></div>
<div><br>
</div>
<p></p>
<p><br>
</p>
<p>My PC compile environment as blew:</p>
<p><span>Linux mi-HP-ProDesk-680-G6-PCI-Microtower-PC 5.4.0-150-generic #16=
7~<b>18.04.1-Ubuntu</b> SMP Wed May 24 00:51:42 UTC 2023 x86_64 x86_64 x86_=
64 GNU/Linux</span><br>
</p>
<p><span><br>
</span></p>
<p><span><span>*** <b>Zstandard </b>CLI (64-bit) v1.5.6, by Yann Collet ***=
</span><br>
</span></p>
<p><span><span><br>
</span></span></p>
<p><span><span></span></span></p>
<div>mi@mi-HP-ProDesk-680-G6-PCI-Microtower-PC:~/xiaoms/Project/erofs/sourc=
ecode/erofs-utils$
<b>./configure --with-libzstd</b></div>
<div>checking for a BSD-compatible install... /usr/bin/install -c</div>
<div>...</div>
<div>
<div>checking zstd.h usability... yes</div>
<div>checking zstd.h presence... yes</div>
<div>checking for zstd.h... yes</div>
<div>checking for ZSTD_compress2 in -lzstd... yes</div>
<div>checking whether ZSTD_compress2 is declared... yes</div>
<div>checking for ZSTD_getFrameContentSize... yes</div>
<div>checking that generated files are newer than configure... done</div>
<div>configure: creating ./config.status</div>
<div>config.status: creating Makefile</div>
<div>config.status: creating man/Makefile</div>
<div>config.status: creating lib/Makefile</div>
<div>config.status: creating mkfs/Makefile</div>
<div>config.status: creating dump/Makefile</div>
<div>config.status: creating fuse/Makefile</div>
<div>config.status: creating fsck/Makefile</div>
<div>config.status: creating config.h</div>
<div>config.status: config.h is unchanged</div>
<div>config.status: executing depfiles commands</div>
<div>config.status: executing libtool commands</div>
<br>
</div>
<div>
<div>mi@mi-HP-ProDesk-680-G6-PCI-Microtower-PC:~/xiaoms/Project/erofs/sourc=
ecode/erofs-utils$
<b>make&nbsp;</b></div>
<div>make&nbsp; all-recursive</div>
<div>make[1]: =BD=F8=C8=EB=C4=BF=C2=BC=A1=B0/home/mi/xiaoms/Project/erofs/s=
ourcecode/erofs-utils=A1=B1</div>
<div>Making all in man</div>
<div>make[2]: =BD=F8=C8=EB=C4=BF=C2=BC=A1=B0/home/mi/xiaoms/Project/erofs/s=
ourcecode/erofs-utils/man=A1=B1</div>
<div>make[2]: =B6=D4=A1=B0all=A1=B1=CE=DE=D0=E8=D7=F6=C8=CE=BA=CE=CA=C2=A1=
=A3</div>
<div>make[2]: =C0=EB=BF=AA=C4=BF=C2=BC=A1=B0/home/mi/xiaoms/Project/erofs/s=
ourcecode/erofs-utils/man=A1=B1</div>
<div>Making all in lib</div>
<div>make[2]: =BD=F8=C8=EB=C4=BF=C2=BC=A1=B0/home/mi/xiaoms/Project/erofs/s=
ourcecode/erofs-utils/lib=A1=B1</div>
<div>make[2]: =B6=D4=A1=B0all=A1=B1=CE=DE=D0=E8=D7=F6=C8=CE=BA=CE=CA=C2=A1=
=A3</div>
<div>make[2]: =C0=EB=BF=AA=C4=BF=C2=BC=A1=B0/home/mi/xiaoms/Project/erofs/s=
ourcecode/erofs-utils/lib=A1=B1</div>
<div>Making all in mkfs</div>
<div>make[2]: =BD=F8=C8=EB=C4=BF=C2=BC=A1=B0/home/mi/xiaoms/Project/erofs/s=
ourcecode/erofs-utils/mkfs=A1=B1</div>
<div>/bin/sh ../libtool&nbsp; --tag=3DCC&nbsp; &nbsp;--mode=3Dlink gcc -Wal=
l -I../include -g -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64&nbsp; &n=
bsp;-o mkfs.erofs mkfs_erofs-main.o ../lib/liberofs.la&nbsp; -luuid -llz4&n=
bsp; -lz&nbsp; -L/usr/local/lib -lzstd&nbsp;&nbsp;</div>
<div>libtool: link: gcc -Wall -I../include -g -O2 -D_LARGEFILE_SOURCE -D_FI=
LE_OFFSET_BITS=3D64 -o mkfs.erofs mkfs_erofs-main.o&nbsp; ../lib/.libs/libe=
rofs.a -luuid -llz4 -lz -L/usr/local/lib -lzstd</div>
<div>make[2]: =C0=EB=BF=AA=C4=BF=C2=BC=A1=B0/home/mi/xiaoms/Project/erofs/s=
ourcecode/erofs-utils/mkfs=A1=B1</div>
<br>
</div>
<div><br>
</div>
<br>
<p></p>
<p><br>
</p>
</div>
#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address
 is listed above. Any use of the information contained herein in any way (i=
ncluding, but not limited to, total or partial disclosure, reproduction, or=
 dissemination) by persons other than the intended recipient(s) is prohibit=
ed. If you receive this e-mail in
 error, please notify the sender by phone or email immediately and delete i=
t!******/#
</body>
</html>

--_000_0a71474744854fcf967e99666e8eab38xiaomicom_--
