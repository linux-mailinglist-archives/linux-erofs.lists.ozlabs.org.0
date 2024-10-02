Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 977AA98D3D7
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 14:58:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XJZcV1qKmz2yVF
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 22:58:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727873910;
	cv=none; b=Z9FLhb27buRVyiIS6+4zzInz3gW2w427JIQzkPnFJCy+5ttUpDOX96TerWLSIU1RcKumnFoF9w6NOJrOapwzeKpd7Fii+VT6NUKhF44DHUWF/j4HxTyJydijlv7dVqSOa/qrQS0UsEgQdDdqapX4U04mjYfbyuGG+Sq6aDz3wuZoKnKPMfCReipJBvtinr3FVXxN9Loj90V678ABIGbFb1Zk508loYp6liJdafg0k98qKLWAKFxpvLWblo0xynqLL+EcB2mQUUDAbszU2wuaIQu+sTqVJDAHEwu9M7ArI87C93Zc6a6WJIsd/MTbdHLAx+RDqdB95eTf0SSgC+V6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727873910; c=relaxed/relaxed;
	bh=A+0k+YE1QvOFNqsycJcooDTbunvSNmsPmgYKLUBQ3/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gssd+d2CMyPSW9Iksk0unTWpfbuCwhsd2DbU4+uRb75G6AF/vUkNbhzYsg6vwzP52e9qM3I0STydb4HNHjyvZ78pqE8FhzUcqZk5Aa/kzWqYu4k7hyNa7P5/6+5VUgqeE9dDj5sESCf7XJnfPV+yrAdPQLuf1hs/8j/DjinWkv9xpw45zpO4/ItencpFL78D56FfOgiXH7d83A3lQ35oPVTPAc+0E+VuNwD6Y6ZPbHLfPbL/9/2HJyCfzGjW03WbLqMQi250yet3J5vmZoEpTuaRfFhYS+Yk8CC2dLL7G8vZPEjItkc0zUoAjO4n7C9Nfd1mtVSujx1Sz/vv0Jfm5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bf26uFIK; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bf26uFIK; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alortie@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bf26uFIK;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bf26uFIK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alortie@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XJZcQ0zG5z2xFm
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Oct 2024 22:58:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727873902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=A+0k+YE1QvOFNqsycJcooDTbunvSNmsPmgYKLUBQ3/o=;
	b=Bf26uFIK43jUpGNpK4NdvVotZxABC7Cj9xw63SuPhg8Cvv/HHEpDOt3Q89bLN+QjxNzRmf
	p51dD8SGPL8CGTBXIvbsApoz2oQCN/vhBpYbrLXtRODGlfpXylqQC8cgvMATg0Fa4zv37N
	TQuLLkXD9yYAMIrPLyBlrKZLpMtIP2s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727873902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=A+0k+YE1QvOFNqsycJcooDTbunvSNmsPmgYKLUBQ3/o=;
	b=Bf26uFIK43jUpGNpK4NdvVotZxABC7Cj9xw63SuPhg8Cvv/HHEpDOt3Q89bLN+QjxNzRmf
	p51dD8SGPL8CGTBXIvbsApoz2oQCN/vhBpYbrLXtRODGlfpXylqQC8cgvMATg0Fa4zv37N
	TQuLLkXD9yYAMIrPLyBlrKZLpMtIP2s=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-UNemPiJUOAqVVUMOPkqzlQ-1; Wed, 02 Oct 2024 08:58:20 -0400
X-MC-Unique: UNemPiJUOAqVVUMOPkqzlQ-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5097c4b142fso1061429e0c.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 02 Oct 2024 05:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873900; x=1728478700;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+0k+YE1QvOFNqsycJcooDTbunvSNmsPmgYKLUBQ3/o=;
        b=HoNkChZD7fMGBz1k0OFXDPklc268ajkOvxIQWfyMva6qJv2MPzU7tTmVr2g65bbz5A
         uRu+Ls3vjUbQtpS1bXDOgWJ/b8yQIdjFQ3BHG845Y4L1gV0UpKzpOOG0Vz67QydF45Mb
         s+7ZoIwVBxpU3eqdnjMWBYh5XomtY5SfaXHOcI0P37QIRk+QIl6Dui91CH3BjwSVu+/T
         5F2EVcOpJf4G6CEbXzWihfQVMd7RqZRllgNBCEokNPoagBF5b+EwGOS7Mx7rdPzcJdTN
         iZeHFbYphXqpWvkSVUcTbJF2oifO3EkwsAcOPbN3I36FKWfZH8xcUrxwbo8tmuoxYlhk
         mfMA==
X-Forwarded-Encrypted: i=1; AJvYcCV0fKiVUH0PgUSgYFIVwr/9sumWQYKBhCskMjsoME/c4g+WIXXZ4B9u9Htx4mcB5ICdyHqLlFkoRW+M9A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYkpqtDlRhL2c5nX8OmR8qbYi7y/bWcG0+aNFv2kuS3exYabre
	oQw/f6RiHic3ICgZd7tsxjbra+c/k/5clFCxZw3BTo/Umv3f2P1UIP4eJLC5s9HCamVh9Mr9wkQ
	cLkUx1/0TCWR3YOWT4uQ9QoZzqDNRH7tOz9N6ZUMEHswrr674wIToMBOO1zGQ5FULi48EiOrGjK
	vF/mD+9kUCByiHXURlQNZ/IDipEPfqkhQAbQWu
X-Received: by 2002:a05:6122:3c49:b0:4ef:5744:46a with SMTP id 71dfb90a1353d-50c5810833fmr3265730e0c.1.1727873899762;
        Wed, 02 Oct 2024 05:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED+CssAdU61T4h+iYFTZHzxI7Nm1TFNzlS1NGurVcoZ1JxEQd+QTjLUTmtFLv2tPgJy2IqY00u2N3JmvFqFbU=
X-Received: by 2002:a05:6122:3c49:b0:4ef:5744:46a with SMTP id
 71dfb90a1353d-50c5810833fmr3265708e0c.1.1727873899388; Wed, 02 Oct 2024
 05:58:19 -0700 (PDT)
MIME-Version: 1.0
From: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Date: Wed, 2 Oct 2024 14:58:08 +0200
Message-ID: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
Subject: Incorrect error message from erofs "backed by file" in 6.12-rc
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fd78a806237dfd55"
X-Spam-Status: No, score=-0.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HTML_MESSAGE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

--000000000000fd78a806237dfd55
Content-Type: text/plain; charset="UTF-8"

hi,

In context of my work on composefs/bootc I've been testing the new support
for directly mounting files with erofs (ie: without a loopback device) and
it's working well.  Thanks for adding this feature --- it's a huge quality
of life improvement for us.

I've observed a strange behaviour, though: when mounting a file as an
erofs, if you read() the filesystem context fd, you always get the
following error message reported: Can't lookup blockdev.

That's caused by the code in erofs_fc_get_tree() trying to call
get_tree_bdev() and recovering from the error in case it was ENOTBLK and
CONFIG_EROFS_FS_BACKED_BY_FILE.  Unfortunately, get_tree_bdev() logs the
error directly on the fs_context, so you get the error message even on
successful mounts.

It looks something like this at the syscall level:

fsopen("erofs", FSOPEN_CLOEXEC)         = 3
fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
fsconfig(3, FSCONFIG_SET_STRING, "source", "/home/lis/src/mountcfs/cfs", 0)
= 0
fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
fsmount(3, FSMOUNT_CLOEXEC, 0)          = 5
move_mount(5, "", AT_FDCWD, "/tmp/composefs.upper.KuT5aV",
MOVE_MOUNT_F_EMPTY_PATH) = 0
read(3, "e /home/lis/src/mountcfs/cfs: Can't lookup blockdev\n", 1024) = 52

This is kernel 6.12.0-0.rc0.20240926git11a299a7933e.13.fc42.x86_64 from
Fedora Rawhide.

It's a pretty minor issue, but it sent me on a wild goose chase for an hour
or two, so probably it should get fixed before the final release.

Thanks again for this awesome feature!

Allison Karlitskaya

--000000000000fd78a806237dfd55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>hi,</div><div><br></div><div>In context of my work on=
 composefs/bootc I&#39;ve been testing the new support for directly mountin=
g files with erofs (ie: without a loopback device) and it&#39;s working wel=
l.=C2=A0 Thanks for adding this feature --- it&#39;s a huge quality of life=
 improvement for us.</div><div><br></div><div>I&#39;ve observed a strange b=
ehaviour, though: when mounting a file as an erofs, if you read() the files=
ystem context fd, you always get the following error message reported: Can&=
#39;t lookup blockdev.</div><div><br></div><div>That&#39;s caused by the co=
de in erofs_fc_get_tree() trying to call get_tree_bdev() and recovering fro=
m the error in case it was ENOTBLK and CONFIG_EROFS_FS_BACKED_BY_FILE.=C2=
=A0 Unfortunately, get_tree_bdev() logs the error directly on the fs_contex=
t, so you get the error message even on successful mounts.</div><div><br></=
div><div>It looks something like this at the syscall level:</div><div><br><=
/div><div>fsopen(&quot;erofs&quot;, FSOPEN_CLOEXEC) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D 3<br>fsconfig(3, FSCONFIG_SET_FLAG, &quot;ro&quot;, NULL, 0) =3D=
 0<br>fsconfig(3, FSCONFIG_SET_STRING, &quot;source&quot;, &quot;/home/lis/=
src/mountcfs/cfs&quot;, 0) =3D 0<br>fsconfig(3, FSCONFIG_CMD_CREATE, NULL, =
NULL, 0) =3D 0<br>fsmount(3, FSMOUNT_CLOEXEC, 0) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 5<br>move_mount(5, &quot;&quot;, AT_FDCWD, &quot;/tmp/compose=
fs.upper.KuT5aV&quot;, MOVE_MOUNT_F_EMPTY_PATH) =3D 0<br>read(3, &quot;e /h=
ome/lis/src/mountcfs/cfs: Can&#39;t lookup blockdev\n&quot;, 1024) =3D 52</=
div><div><br></div><div>This is kernel 6.12.0-0.rc0.20240926git11a299a7933e=
.13.fc42.x86_64 from Fedora Rawhide.</div><div><br></div><div>It&#39;s a pr=
etty minor issue, but it sent me on a wild goose chase for an hour or two, =
so probably it should get fixed before the final release.<br></div><div><br=
></div><div>Thanks again for this awesome feature!</div><div><br></div><div=
>Allison Karlitskaya<br></div></div>

--000000000000fd78a806237dfd55--

