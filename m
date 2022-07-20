Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8956B57BF4C
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jul 2022 22:42:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lp71C3JCBz3c4B
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jul 2022 06:42:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aparcar.org (client-ip=2001:4b98:dc4:8::240; helo=mslow1.mail.gandi.net; envelope-from=mail@aparcar.org; receiver=<UNKNOWN>)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lp7171W1Hz302S
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jul 2022 06:42:18 +1000 (AEST)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 42FE7C7033
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Jul 2022 20:38:36 +0000 (UTC)
Received: from smtpclient.apple (ip5f5ab6af.dynamic.kabel-deutschland.de [95.90.182.175])
	(Authenticated sender: mail@aparcar.org)
	by mail.gandi.net (Postfix) with ESMTPSA id 2D50A40003
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Jul 2022 20:38:16 +0000 (UTC)
From: Paul Spooren <mail@aparcar.org>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_BF5CDE20-82AD-444D-BBFF-33F849F4E600";
	protocol="application/pgp-signature";
	micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Tail packing feature on 5.15 Kernel
Message-Id: <DA1A8293-6DE7-49EA-B109-162B121C601A@aparcar.org>
Date: Wed, 20 Jul 2022 22:38:15 +0200
To: linux-erofs@lists.ozlabs.org
X-Mailer: Apple Mail (2.3696.100.31)
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--Apple-Mail=_BF5CDE20-82AD-444D-BBFF-33F849F4E600
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi all,

I=E2=80=99m currently in the process[1] to evaluate erofs as a =
replacement of squashfs on OpenWrt.

Since 5.15 will be our next Kernel release but tail packing is only =
available starting from 5.17, did anyone already do the work of back =
porting the required patches? If not, could anyone please give me =
pointers which patches are required?

Thank you very much for all further advice!

Best,
Paul

[1]: https://github.com/openwrt/openwrt/pull/9968

--Apple-Mail=_BF5CDE20-82AD-444D-BBFF-33F849F4E600
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdcbMP2OpBP09A4ZQT6phiUXRMEAFAmLYZ7cACgkQT6phiUXR
MEB2sw/+NeCVOGcIc6jkPB1aFfmTFEP4iBwmF803F5pKqA/koW2eokTPTQmppRxJ
tQ1LtSu9FOZedAq5UEkAVSr4PPndG1Bktehw0KYsuxFC8N+6VfGPCMCCyGvfx7ad
++TfQSSHX6CfgsDEyT+N3yL62O5V0OtTxUEExw5d6ZM/dGf0XYKMsi4Ts0bmZkHo
7yM/k5UZ5lktNBETkO0QBo26HcOSmvBZ7OUrt37Rl1MqJGszyCkIw8zUssu44WK6
xeI3tcqRwWGa0kI9zERqRlrUwLcze0SkEKn42l08ySG5tqipRTPQxhZLcpQ4vkro
0juMFcZbGdmFMTjJwoLTM0I4iU5/FnoYiPVGCG8MqZEhUAXyNDDZrPv7vhpoBT0A
Nl6Why31NQ1N5Eq8ZWtqQ9ApiC/3cXY5/mE0K8q6mVZwFt3xUtV5GFzg7tOMTcuv
Pe/pMbuW4nWSsUQA5A3r4eAfP63lqLbpYJrHpz4cSTQzXcvH1wKf6DKEwkG8jkh4
50yiUzCq+aSdzbdbyqxYIb9Jq6HqhYvdNSyg0jf9M04Fbbtar7jQi6TsLUiAzszA
jRm6A5ZlwxarqASLJJ6LUGj6Oz0hMG8Ir3O+XaHalobT+DBZNEOVLQJgLvYSjIUH
HYC+dhhXI1XmtsBL6Rjl/nPGwPz4zS7N6gcp2kEEcNC571C3t6k=
=9Tgc
-----END PGP SIGNATURE-----

--Apple-Mail=_BF5CDE20-82AD-444D-BBFF-33F849F4E600--
