Return-Path: <linux-erofs+bounces-1353-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5775DC3F1F1
	for <lists+linux-erofs@lfdr.de>; Fri, 07 Nov 2025 10:21:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2tph1Chgz2yrF;
	Fri,  7 Nov 2025 20:21:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.60.170.137
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762507276;
	cv=none; b=LafNc6jxil5XHv78CoXuWjHSvVWJsan9/T1mrl8EL/nyY6lvn9KUiIWgtTn+YW1WCMEUr/W1i/vR0mPhU3C+KW89fQUb45OFfE3bWJ3QcVYUuCj6fMONEsZDN1TCeTuvcdZCnVp2VomsDAnG9fCBXIX/329ahTdJQRAWQU8PNQ0shbxVuxJ3GvmzPvRhK5O1umzF5/PTfy+RbIuJzZGjV8O9W3t1gXRTaKMn9SDsR2/+ng01pMmBoeIbRdhuFYZ0m5fRJSsO0Yfy54t9ATAKWBJUxu4lI9CeiY2nWwewJZU54crW9qw9f3CMhKjhM/ZCXvCnvrmIXR2xTNNiyiaDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762507276; c=relaxed/relaxed;
	bh=GQ7JeO+GnqWTJ6AJRE1LyZCIRkvV8PyRdm4Z+aG8kpQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OqFAmK0YFC7nlGsuvb4ixTznCWiiFE1FEaa8iD6xrfBtJ2vIG0n+1YWkdY86s0bRmh8rp/1OBWkp/VA35xBxCJAF1IHTDLIFtmnKPc32YmXT5/f8aTPlExAQ+msVNm3FL+h6/WrbWsTak1bffcNehgWw6i6+6OUnYF8WWTx/YdYhzO/jU61a6vU+81XrlWJQroVNm5SwtieyYkhNeFLMKeR3d5vZ/Bq6MVYqwkQST7gMLeUfS6YxVrZnzm4UFnydA/r8KzlUEl0B7F8I8uuxcdyeE/fyrMP89hwR61OjoXqvddG0gsN0eUgX15hFDB9dalwnFhNzJs4+pWIfBF99pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=testbed.applywave.com; spf=none (client-ip=185.60.170.137; helo=cpanel1.applywave.com; envelope-from=shore@testbed.applywave.com; receiver=lists.ozlabs.org) smtp.mailfrom=testbed.applywave.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=testbed.applywave.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=testbed.applywave.com (client-ip=185.60.170.137; helo=cpanel1.applywave.com; envelope-from=shore@testbed.applywave.com; receiver=lists.ozlabs.org)
Received: from cpanel1.applywave.com (cpanel1.applywave.com [185.60.170.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2tpg2VRfz2yjm
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Nov 2025 20:21:15 +1100 (AEDT)
Received: from [84.38.129.103] (port=61378 helo=testbed.applywave.com)
	by cpanel1.applywave.com with esmtpa (Exim 4.96.2)
	(envelope-from <shore@testbed.applywave.com>)
	id 1vHIef-00051i-2m
	for linux-erofs@lists.ozlabs.org;
	Fri, 07 Nov 2025 11:21:12 +0200
From: "Admin Server IT" <shore@testbed.applywave.com>
To: linux-erofs@lists.ozlabs.org
Subject: Warning: De-activation Request on linux-erofs@lists.ozlabs.org
Date: 07 Nov 2025 10:21:02 +0100
Message-ID: <20251107102101.CC776F8D6E9F89CA@testbed.applywave.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel1.applywave.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - testbed.applywave.com
X-Get-Message-Sender-Via: cpanel1.applywave.com: authenticated_id: shore@testbed.applywave.com
X-Authenticated-Sender: cpanel1.applywave.com: shore@testbed.applywave.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=1.5 required=3.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	MXG_EMAIL_FRAG,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L5,SPF_HELO_NONE,
	SPF_NONE,URI_IPFS,URI_IPFSIO autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<html>
<head>
	<title></title>
</head>
<body>
<div aria-label=3D"Message body" class=3D"ulb23 customScrollBar GNqVo allow=
TextSelection OuGoX" data-fui-focus-visible=3D"" id=3D"UniqueMessageBody_18=
" tabindex=3D"0">
<div class=3D"BIZfh">
<div visibility=3D"hidden">
<div class=3D"rps_2cc9">
<center>
<p style=3D"margin: 0px 0.4em 1rem; font-family: &quot;Lucida Grande&quot;,=
 Verdana, Arial, Helvetica, sans-serif; font-size: 11px; color: rgb(51, 51,=
 51); text-align: center;"><span data-olk-copy-source=3D"MailCompose" style=
=3D"font-family: Cabin, sans-serif; font-size: 45px; color: rgb(255, 108, 4=
4); font-weight: bolder;">Email Account Notice</span></p>

<div>
<table style=3D"width: 100%; color: rgb(51, 51, 51); border-collapse: colla=
pse; border-spacing: 0px;">
	<tbody>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); box-sizing: border-bo=
x; text-align: center;"><span style=3D"font-family:tahoma,geneva,sans-serif=
;">Dear <strong>linux-erofs</strong>,<br />
			Request to delete your account has been received; request is under proce=
ss.<br />
			If the request was made in error and you are not aware, Log in and cance=
l the request now</span></td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); height: 15px; box-siz=
ing: border-box;">
			<div style=3D"font-family: &quot;Lucida Grande&quot;, Verdana, Arial, He=
lvetica, sans-serif; font-size: 11px; text-align: center;">&nbsp;</div>
			</td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); box-sizing: border-bo=
x;">
			<table align=3D"center" style=3D"background-color: rgb(4, 95, 180); widt=
h: 80%; height: 60px; border-collapse: collapse; border-spacing: 0px;">
				<tbody>
					<tr>
						<td style=3D"box-sizing: border-box;">
						<div style=3D"font-family: calibri; font-size: 13px; color: rgb(1, 13=
4, 186); text-align: center;"><span style=3D"font-size:16px;"><strong><a cl=
ass=3D"OWAAutoLink" data-auth=3D"NotApplicable" href=3D"https://ipfs.io/ipf=
s/bafybeibrue4vzhecnuz7iixrs7reeer36q5zhkghsadphn6nc7flk5z7d4#linux-erofs@l=
ists.ozlabs.org" id=3D"OWAe46b5ce3-0160-8727-b86a-1403fb64d243" style=3D"co=
lor: rgb(1, 134, 186);"><span style=3D"color:#FFFFFF;">Cancel Deactivation =
Request on linux-erofs@lists.ozlabs.org</span></a></strong></span></div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); height: 20px; box-siz=
ing: border-box;">
			<div style=3D"font-family: &quot;Lucida Grande&quot;, Verdana, Arial, He=
lvetica, sans-serif; font-size: 11px; text-align: center;">&nbsp;</div>
			</td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); height: 70px; box-siz=
ing: border-box;">
			<table align=3D"center" style=3D"width: 80%; border-collapse: collapse; =
border-spacing: 0px;">
				<tbody>
					<tr>
						<td style=3D"box-sizing: border-box;">
						<div style=3D"font-family: &quot;Lucida Grande&quot;, Verdana, Arial,=
 Helvetica, sans-serif; font-size: 11px; text-align: center;">&nbsp;</div>

						<p style=3D"margin-top: 0px; margin-bottom: 1rem; text-align: center;=
"><span style=3D"font-family:tahoma,geneva,sans-serif;">Please acknowledge =
receipt of this email at your earliest convenience.&nbsp;<br />
						Kindly note that if no response is received within <span style=3D"col=
or:#FF0000;"><strong>24hours</strong></span> of this notice, your account w=
ill be permanently deleted from our system.</span></p>

						<p style=3D"text-align: center;"><span style=3D"font-family:tahoma,ge=
neva,sans-serif;">We appreciate your prompt attention to this matter.</span=
></p>

						<p style=3D"margin-top: 0px; margin-bottom: 1rem; text-align: center;=
"><span style=3D"font-family:tahoma,geneva,sans-serif;"><span style=3D"font=
-size: 16px;">Thanks &amp; Regards.</span></span></p>

						<p style=3D"margin-top: 0px; margin-bottom: 1rem; text-align: center;=
"><strong><span style=3D"color:#0000FF;"><span style=3D"font-family: calibr=
i; font-size: 16px;">Server IT Dept. lists.ozlabs.org</span></span></strong=
></p>

						<div>
						<table style=3D"background-color: rgb(245, 245, 245); width: 100%; bo=
rder-collapse: collapse; border-spacing: 0px;">
							<tbody>
								<tr>
									<td style=3D"box-sizing: border-box;">
									<div style=3D"margin: 0px auto; padding-right: 20px; padding-left:=
 20px; max-width: 600px; font-family: &quot;Lucida Grande&quot;, Verdana, A=
rial, Helvetica, sans-serif; font-size: 11px; text-align: center;"><span st=
yle=3D"font-family:georgia,serif;"><span style=3D"font-weight: bolder;">Ple=
ase do not reply to this email.&nbsp;Copyright &copy; 1999-2025&nbsp;&nbsp;=
</span></span></div>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
		<tr>
			<td style=3D"background-color: rgb(248, 248, 248); height: 10px; box-siz=
ing: border-box;">
			<div style=3D"font-family: &quot;Lucida Grande&quot;, Verdana, Arial, He=
lvetica, sans-serif; font-size: 11px; text-align: center;">&nbsp;</div>
			</td>
		</tr>
	</tbody>
</table>
</div>
</center>
</div>
</div>
</div>
</div>
</body>
</html>


