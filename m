Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB797F0C7
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 20:43:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCBhd0H36z2yVV
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 04:43:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727117006;
	cv=none; b=jEhVYKa2hNhVshXCjjgvTw0BcuKXCeAHDfsUwpD/ScsmlPeTLcPgyHvdqCiEaSeDSvNZBrtrrTCVQxsE451Mp08TtCluEI3iGBuzZ5KQaSCzZT6jfsKbsCbPmLayaB8SOLnzwZ5Ue5PKWU5dhftummcZQSZD9cPx4bGstKOAG/KXYeF+HJYIMSweVjozCXLmLNYEeu1V4jSWbOr+dSwx8gadzS3fe2GNlip8zl/HymljPUqEDgLBsYm/xKxG9OAqHFkq5SldZXqkCL79IhxgQTKCmZ4ZgXIhvoV3kq68TuP8iq8mBf0RlB7BFlGIf9j1MMkrw20/XDyDnI+f+GGaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727117006; c=relaxed/relaxed;
	bh=2LHmjzXAtMIZmJ5Rn7lQK9rTwNZYqrEZiN8cZ0JMhp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ahI3hwGIW/6RIYOFKn3G4cr7YUtYpEoPMZr+YfWgSOvdLUmx1E5/qjOul3YE/4Rblvlyp9q39x+UjG2USWB8IjWZX5DGRT06WfUHTGZ2kWu2pPsYQoliZgUoRj6ZqKWo+OgP93ti5uBl4X5+Pr4FFLGJe/+9o7oipI0EXvWiQ2skff0b/1k7AwhKwKn/8Gj2fOVntCNzCYp8MTylbgj6fuw7miPW1Zv0owjvoIiMGCcW50cciVo1hIb6IwCID36pvRLiW30GtLVy4nBD0Ftdm4pn46GH24M4FH2iF/53rg2cUllfmVMId3s2Gz44NQKSASSAeDNI6NtOYIqtJ9hAdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bQPTzBMj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bQPTzBMj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCBhZ14RQz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 04:43:25 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2057835395aso52645405ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727117002; x=1727721802; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2LHmjzXAtMIZmJ5Rn7lQK9rTwNZYqrEZiN8cZ0JMhp8=;
        b=bQPTzBMj8elHdARG2N8qNE75xbOVXAL18Sl8nX3f/vanXdYNTR9aLegIgoMnUIj9+l
         EnQxf0Q5bW31LhP8Nu7m2PLy4b4fCeTlO/Z1OGkMh/E9lORBCSLyydwwWrZzW85p9WRL
         Rb9x8wPaowjl4wgl76q9r94eDjR9BiFlpSrhFIRs+UMdFHtd846eE27VxDBOFXiy9Kfg
         NliJ6rzmmHtwPqrsPSCfNie5z0Uua5xhHFWogEo5bkLKa5cxii/kVUHkRdESzG1njaMM
         7T97zioTuWtvijUjDkDKBuW0nubvaDumCZU4vFzCM+Jr/N8VYWB8wdom07dsVpeFq4LX
         mGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117002; x=1727721802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LHmjzXAtMIZmJ5Rn7lQK9rTwNZYqrEZiN8cZ0JMhp8=;
        b=eI5eXt0DY0nEIh6RpegHMnFKfoWJyCAgxooA4yLZuTkQA6/9KGoV8dKsO5RAlcvCpP
         mue42HVz8mFj+gXnyDJp4cJYkQLvdICLUIrQV8SWceweWoznmVi7N5+6ADihH1c6TGZ0
         UyEOmyfa4S+ctvpxWw2HUemNWzSyFdj4RTlX4SvGX2aA5ZwvJGjgQ4B40fZhfU2oqA5c
         20oezfEK1bytFSE6jS7pVh5kay/imkV02sBZrM8a3N+AjvNkuEfHe75KMqGFJGRKoQuy
         hZJUVFNFEg27tyAfP4FRtpO+kToDQNffhCNG+Vc3rLTJtR/JCjXT7ykuyTTW1kGOmdkc
         3ZtA==
X-Forwarded-Encrypted: i=1; AJvYcCXQprMnzJlxtZJnUtNK0A8fSArLc85ZsgwSFHRB0UQczZTH8YCYh1SNwmu1ejWp6NhzQyvxayyS4y9xVw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz6GOiDMY343arCnd40NhalfKII5Nil8qTJ5lOgEWUos4DoRSV2
	cUGshhKrnwbqE7rwUP3+wJeaGf4MzYW2y5HELpthMAImNXh96MdA
X-Google-Smtp-Source: AGHT+IHPhZrggldPhDzAISSCt7hDQP+r1zqFPPuYtS+By/R474KzhLZIXK5fLtO4N5rEH3YS+YNQYw==
X-Received: by 2002:a17:902:ecc2:b0:207:3fd0:13ec with SMTP id d9443c01a7336-208d836cef7mr234528045ad.17.1727117002177;
        Mon, 23 Sep 2024 11:43:22 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601008sm135317725ad.81.2024.09.23.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 11:43:21 -0700 (PDT)
Message-ID: <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>, dhowells@redhat.com
Date: Mon, 23 Sep 2024 11:43:16 -0700
In-Reply-To: <20240923183432.1876750-1-chantr4@gmail.com>
References: <20240814203850.2240469-20-dhowells@redhat.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 2024-09-23 at 11:34 -0700, Manu Bretelle wrote:

[...]

> The qemu command invoked by vmtest is:
>=20
> qemu-system-x86_64 "-nodefaults" "-display" "none" "-serial" "mon:stdio" =
\
>   "-enable-kvm" "-cpu" "host" "-qmp" "unix:/tmp/qmp-971717.sock,server=3D=
on,wait=3Doff" \
>   "-chardev" "socket,path=3D/tmp/qga-888301.sock,server=3Don,wait=3Doff,i=
d=3Dqga0" \
>   "-device" "virtio-serial" \
>   "-device" "virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0"=
 \
>   "--device" "virtio-serial" \
>   "-chardev" "socket,path=3D/tmp/cmdout-508724.sock,server=3Don,wait=3Dof=
f,id=3Dcmdout" \
>   "--device" "virtserialport,chardev=3Dcmdout,name=3Dorg.qemu.virtio_seri=
al.0" \
>   "-virtfs" "local,id=3Droot,path=3D/,mount_tag=3D/dev/root,security_mode=
l=3Dnone,multidevs=3Dremap" \
>   "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
>   "-no-reboot" "-append" "rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,cach=
e=3Dmmap,msize=3D1048576 rw earlyprintk=3Dserial,0,115200 printk.devkmsg=3D=
on console=3D0,115200 loglevel=3D7 raid=3Dnoautodetect init=3D/tmp/vmtest-i=
nit4PdCA.sh panic=3D-1" \
>   "-virtfs" "local,id=3Dshared,path=3D/data/users/chantra/linux,mount_tag=
=3Dvmtest-shared,security_model=3Dnone,multidevs=3Dremap" \
>   "-smp" "2" "-m" "4G"

fwiw: removing "cache=3Dmmap" from "rootflags" allows VM to boot and run te=
sts.

