Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE72B97F1A7
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 22:21:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCDsK0VJhz2yVd
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 06:21:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::12c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727122866;
	cv=none; b=L9Gcd+7e7xrEIaWDehK6pA1OKi04u8rC6WZ8dUG6svYDOJMOn0YIOqu/qwfTC4+cz6qi8EqrW+eUu1TN2/pJJMu21HhpuVxy9+9hM55ShAktBvtg9lFlmgryqGVkFKvRMRj4AUzyYMPpxR6cjHGTHl1B0YjyiuLrcZeikARhKs8qEjK/9j3s8ufiUcxkA5nwmKHFt5rdVX2FZpyRHhAZOcssJTSaGzG/6DopWu+sYhX38iD5PM5pEE2j/FkifcXTbORzEePLzpYInCqDgESJyErCApnTdoXYy4mfjo8bdtOh+ivHjfHB6OxtM1aDiRGFu3sHWDfjw51mrCh1BuRcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727122866; c=relaxed/relaxed;
	bh=NleUZATndt1acwKzBa7y/6tS+SaA3XdbIXpdmDlWmuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bboLfGoL+qzcY0E6TSQDD3BeWm7UBu+Igd5AiqFJDYESFF24RoOBh5gWHOLFJvohcOqcQov7KxPawLCz33LifAoWALqalTYNbN/nx/7QIyy+Wl+hNFTn8F5zrJvIp3JDW9xlrza8oQZSomHSfnXWqDRg86GAhG6A4+WPJ8+xjC3SWV1RPiXYbP2VZWY71B9a29aT8IOkhY9SNAOhanOUd8EwHbJ9da3QBf2+ffaMjvGxmNZRAijGEBojpq8Z51qPoPbf/O5WgRvgLQ8YxAr9yLX4h27h3dVygeNEbQZGlTWltum7mU+QBsk/AhRG5EWNQATs4YeLpfw/7nU5gkT50Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NdfNuIp4; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=chantr4@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NdfNuIp4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=chantr4@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCDsF4w18z2xjv
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 06:21:04 +1000 (AEST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5365b6bd901so5536050e87.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727122859; x=1727727659; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NleUZATndt1acwKzBa7y/6tS+SaA3XdbIXpdmDlWmuM=;
        b=NdfNuIp4VZgzjIfrSdGKbbXhz8IEvaqwPp5BmrAGjJePv+7mZs3y62JoyMrYFFKNJY
         GIZBtIySQo/PL+xI3l/gTFyPd2QxXYGFPoJerVyfgDWax8OGm3nltqZ7Mh5TIT4/BTAk
         OcZUaUpIIYq/NYjCCkO1gB3KfKznT6CzbgTN9w5qCEpGdxGCssRD3o7mYVL41GwHSWj8
         fAAvVCVd1cAVkgRKyQmgFqdLjLvPRMPCZlCN0uyugYBG1ZuxxjbVykv8cXIRJzJUbAHF
         RLVoPTycoRJyNouVvUbB7yOBsu99Lm2ouys5BSJQ+f8HE42oksiM+2jCD1kNeQe9pFWA
         1faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122859; x=1727727659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NleUZATndt1acwKzBa7y/6tS+SaA3XdbIXpdmDlWmuM=;
        b=mqTNazhyKY0zRwu0eU7nzmA73QO2SsgEqHnZnsthPZ5EyYAgjA51xmTlTs8K5sdpEe
         9YZbC28zRYdiP/iVYBMD1nCS14BSynzbq/HLfmqODojM2wVuElhx9AJOb0oWDVkV3lJ0
         2TEHiL2iHqZxzg1sWSSMlmIrzULL3XgYSKEUGY6Jql8LajgnA4kOLtKiCfdTxy7tE5be
         XfIrSbeXxWCBXO3BQfwTRwFsnSEOo+tniQ04IXM9r2cjjE3UsL1GPmiu/9KLPDUQEPaZ
         k/kWajXQyxR030SEhpg199vzb0bi8is/8Ir4keqh6rQ821FDRLmCxFfiVlT/h/0KGvzs
         gaZA==
X-Forwarded-Encrypted: i=1; AJvYcCUpX8UpsEY13RbRu5kEJQfCncv0PhkAvThCRUSmk/8vj2DfrmNtlJVqGltUZ3MspAUzaVFlh+5TXgmIDQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdUrQ5eGKgid+UEiE+vGvOCL4GuRs33X5+SNlvwRIip8dvQV+H
	vNVFRZwWlIqE9BTzRxx8T/M/Fexx0So5LNT/6Vwf5KyBgmn2C8c5qxmgXMGeL5JA9xuT5oqoSAo
	TDzSf0fcphTzP6vSgVpX0tUJLy+o=
X-Google-Smtp-Source: AGHT+IFe6pzcf17Wh1gjew0V8YTIVeE9hLlPHLiePqr1rh/borgYiDBhQWNwMIzi8TlRjg6PaEMoWqREOxcDUAURZmM=
X-Received: by 2002:a05:6512:6c3:b0:535:63a3:c7d1 with SMTP id
 2adb3069b0e04-536ad3b7f23mr6933488e87.48.1727122858742; Mon, 23 Sep 2024
 13:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240814203850.2240469-20-dhowells@redhat.com>
 <20240923183432.1876750-1-chantr4@gmail.com> <912766.1727120313@warthog.procyon.org.uk>
In-Reply-To: <912766.1727120313@warthog.procyon.org.uk>
From: Manu Bretelle <chantr4@gmail.com>
Date: Mon, 23 Sep 2024 13:20:47 -0700
Message-ID: <CAArYzrL0+tiPRhW6Z5fDp4WJgxVBeMg90A44rA=htXku0Q99eQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
To: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, eddyz87@gmail.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 23, 2024 at 12:38=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Hi Manu,
>
> Are you using any other network filesystem than 9p, or just 9p?

Should be 9p only.

We ended up reverting the whole merge with
https://patch-diff.githubusercontent.com/raw/kernel-patches/vmtest/pull/288=
.patch
as my initial commit revert happened to work because of the left over
cached .o.

FWIW, I quickly checked and virtiofs is not affected. e.g is I was to
apply https://github.com/danobi/vmtest/pull/88 to vmtest and recompile
the kernel with:
  CONFIG_FUSE_FS=3Dy
  CONFIG_VIRTIO_FS=3Dy
  CONFIG_FUSE_PASSTHROUGH=3Dy

qemu-system-x86_64 "-nodefaults" "-display" "none" \
  "-serial" "mon:stdio" "-enable-kvm" "-cpu" "host" \
  "-qmp" "unix:/tmp/qmp-895732.sock,server=3Don,wait=3Doff" \
  "-chardev" "socket,path=3D/tmp/qga-733184.sock,server=3Don,wait=3Doff,id=
=3Dqga0" \
  "-device" "virtio-serial" \
  "-device" "virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0" \
  "-object" "memory-backend-memfd,id=3Dmem,share=3Don,size=3D4G" "-numa"
"node,memdev=3Dmem" \
  "-device" "virtio-serial" "-chardev"
"socket,path=3D/tmp/cmdout-713466.sock,server=3Don,wait=3Doff,id=3Dcmdout" =
\
  "-device" "virtserialport,chardev=3Dcmdout,name=3Dorg.qemu.virtio_serial.=
0" \
  "-chardev" "socket,id=3Droot,path=3D/tmp/virtiofsd-807478.sock" \
  "-device" "vhost-user-fs-pci,queue-size=3D1024,chardev=3Droot,tag=3Drootf=
s" \
  "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
  "-no-reboot" "-append" "rootfstype=3Dvirtiofs root=3Drootfs rw
earlyprintk=3Dserial,0,115200 printk.devkmsg=3Don console=3D0,115200
loglevel=3D7 raid=3Dnoautodetect init=3D/tmp/vmtest-initBdg4J.sh panic=3D-1=
" \
  "-chardev" "socket,id=3Dshared,path=3D/tmp/virtiofsd-992342.sock" \
  "-device" "vhost-user-fs-pci,queue-size=3D1024,chardev=3Dshared,tag=3Dvmt=
est-shared"
\
  "-smp" "2" "-m" "4G"

would work.

Manu

>
> David
>
