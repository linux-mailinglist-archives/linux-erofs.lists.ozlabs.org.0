Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA3D98394A
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 23:56:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCGz30D4Dz2yVd
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 07:56:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727128571;
	cv=none; b=Cz4ewJYedZhdbPDyoF11jo8ZICnPF+6XDSBEZeNUmeskpokYbgAKjxcWxMz72UHBMeovg9nTE1QYzOap8MqjBl8t9AKMnKsOpUCZ4MP7Ti2GS6yKSd+pzkO2IdGxPzNPvtpxxLScs1Flmr5YNHObCsDSlkbdq8kuXFWyaaWb7V+wsLAgdWUDkHd/eMmPhctc7ucFq9T7SDwDwABEe5omwQcC0pWmIgGFZ9iCxsp9FoVWFueHRIBp/tM0VRasF+NjFNm9pi4p6J5CGJvgSjjNkyqEcKFmBNryNe6uxY2oE6HOYceoFRwXefEUzGMtV7dxVSlVXD1ySSfThlfP81rpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727128571; c=relaxed/relaxed;
	bh=/8+/Agj95n5lwYDiAPqDI5W15t31UBn8yUoG9/0FMeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iX6VvwsO670oq9rWdNQc/kw95EJgylMEXhi4Abzbm2VZvP+F768YfOo/425q7Z5tYKxC/LoDWQixyEFWNeI2bh4DPZkaYNibWVp1NSzwUwZIfDMIh7I1Cr/fT/6DM+cUh+Yu+AkZDtU06TX7irBhNG3VMD8h48oEGcOlmkZ5e9RmDaNLB0QaWa9IAiA3j3GwAwKwrjRFvi1dv/RoOBOTM4k/YbwghndRF0H2ue0jhHA8I1+iiWDGq5Vc1+2+kpdps3sub1/IUL0clSUpzOMsupHixYFsRyqlvNh4l6ecRKGoxMe9gU3mWNW3ijWpbegr11bvVcEb2gGzlhH+ItgFPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mYcD1638; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mYcD1638;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCGyz084kz2xm5
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 07:56:10 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so2323958a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727128567; x=1727733367; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/8+/Agj95n5lwYDiAPqDI5W15t31UBn8yUoG9/0FMeE=;
        b=mYcD1638+oO6vJcqB+GiVNB9VP8AIP7qCgDsd9/d1ifkA7m3944Oz7BkW2p/jOmh8N
         u1AkSk6XyjLa2msZC24QXNHs/GLKsbao9hBRz3SdX3fsAWm01wTxw1xlvgNKb7W5hXw/
         bIF+WElKrPqiK10npAor2Mw0wDXntEwPWxfJZcSzelJUeQpmNczWWdZ++0apYfQdgc6n
         TDX5vkx7qPXJO//21fba4NPNyPHRk4RER6QTSXH42D9u8yizE/2F2kJHKmQWwsbt9OCc
         732hUEGyyVSrzIumRKG5vAVq8idcd1OkO5hgmp401lqU0/8dcl+DsVFtI6bZDCRgbcTu
         pWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727128567; x=1727733367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8+/Agj95n5lwYDiAPqDI5W15t31UBn8yUoG9/0FMeE=;
        b=TQZXHv1KpNVOa/R/UxF5KshRPbJkNkAxtpBt1fzdfGuiUk/K1Wn148NnuYDB0ZPLr4
         1y6NQxUomxWSqysVSQDyT8HLrhWyeTX5ETuUVMXCA5orvOCSVJ3Vc8YtzKxL8bgRaBSX
         G9M6CTUUMUWIN64JkuElqESSeqaQTPi3uh3KBvBbnLjeXLs58hTzPMQTXK0sFnVvnGdX
         9MGnzJYJ1R1kPgcyjR43CLmLE0OrmAIONA4OjW67hajnsgLNFR1ct1HoZafv7mSCIk9g
         4pY8IRqyfT0Y1thODtD8OKuTOgP/LV/ACcT2tdcnpsOzFvKEbZjZ1TMaulK9MlNtRDfv
         4tFA==
X-Forwarded-Encrypted: i=1; AJvYcCX54k/4DFSywnSLQ1k03UPPkXOP6G4jBgFCzstV8geNMAvuc5zGqYXylExgWgTht6NMJ02puf0C8ZD8hA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9l6Pzt254xQ3gMbKWUVMUWR/XFl9+JOoLpc6ulzc4TdXCob5t
	m3RGg9ziXLOUDeUYRRPSSKlOYvg7grmyn5PgX5phbN4Z+v7D5L4k
X-Google-Smtp-Source: AGHT+IEOWgP+NQYRnWmQn7Tzm3qkB8mabtnbmT8Onpp+Lt2mGQXJbIgQdAxRKso0U9c6JGKqTdiPZA==
X-Received: by 2002:a05:6a21:3983:b0:1d2:e90a:f4aa with SMTP id adf61e73a8af0-1d343c5913dmr1421967637.13.1727128567376;
        Mon, 23 Sep 2024 14:56:07 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c102sm80715b3a.154.2024.09.23.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 14:56:06 -0700 (PDT)
Message-ID: <0f6afef57196cb308aa90be5b06a64793aa24682.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>, dhowells@redhat.com
Date: Mon, 23 Sep 2024 14:56:01 -0700
In-Reply-To: <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
References: <20240814203850.2240469-20-dhowells@redhat.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
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

On Mon, 2024-09-23 at 11:43 -0700, Eduard Zingerman wrote:
> On Mon, 2024-09-23 at 11:34 -0700, Manu Bretelle wrote:
>=20
> [...]
>=20
> > The qemu command invoked by vmtest is:
> >=20
> > qemu-system-x86_64 "-nodefaults" "-display" "none" "-serial" "mon:stdio=
" \
> >   "-enable-kvm" "-cpu" "host" "-qmp" "unix:/tmp/qmp-971717.sock,server=
=3Don,wait=3Doff" \
> >   "-chardev" "socket,path=3D/tmp/qga-888301.sock,server=3Don,wait=3Doff=
,id=3Dqga0" \
> >   "-device" "virtio-serial" \
> >   "-device" "virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.=
0" \
> >   "--device" "virtio-serial" \
> >   "-chardev" "socket,path=3D/tmp/cmdout-508724.sock,server=3Don,wait=3D=
off,id=3Dcmdout" \
> >   "--device" "virtserialport,chardev=3Dcmdout,name=3Dorg.qemu.virtio_se=
rial.0" \
> >   "-virtfs" "local,id=3Droot,path=3D/,mount_tag=3D/dev/root,security_mo=
del=3Dnone,multidevs=3Dremap" \
> >   "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
> >   "-no-reboot" "-append" "rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,ca=
che=3Dmmap,msize=3D1048576 rw earlyprintk=3Dserial,0,115200 printk.devkmsg=
=3Don console=3D0,115200 loglevel=3D7 raid=3Dnoautodetect init=3D/tmp/vmtes=
t-init4PdCA.sh panic=3D-1" \
> >   "-virtfs" "local,id=3Dshared,path=3D/data/users/chantra/linux,mount_t=
ag=3Dvmtest-shared,security_model=3Dnone,multidevs=3Dremap" \
> >   "-smp" "2" "-m" "4G"
>=20
> fwiw: removing "cache=3Dmmap" from "rootflags" allows VM to boot and run =
tests.
>=20

A few more details:
- error could be reproduced with KASAN enabled, log after
  scripts/decode_stacktrace.sh post-processing is in [1];
  (KASAN reports use-after-free followed by null-ptr-deref);
- null-ptr-deref is triggered by access to page->pcp_list.next
  when list_del() is called from page_alloc.c:__rmqueue_pcplist(),
  e.g. the following warning is triggered if added:

  --- a/mm/page_alloc.c
  +++ b/mm/page_alloc.c
  @@ -2990,6 +2990,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, u=
nsigned int order,
                  }
=20
                  page =3D list_first_entry(list, struct page, pcp_list);
  +               WARN_ONCE(!page->pcp_list.next, "!!!!! page->pcp_list.nex=
t is NULL\n");
                  list_del(&page->pcp_list);
                  pcp->count -=3D 1 << order;
          } while (check_new_pages(page, order));
- config used for testing is [2];
- kernel used for testing is [3];

[1] https://gist.github.com/eddyz87/e638d67454558508451331754f946f41
[2] https://gist.github.com/eddyz87/f2c9c267db20ee53a6eb350aba0d2182
[3] de5cb0dcb74c ("Merge branch 'address-masking'")
    https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
