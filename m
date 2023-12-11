Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1980CE1E
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Dec 2023 15:17:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SpkNf4cL1z30fp
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 01:17:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.218.52; helo=mail-ej1-f52.google.com; envelope-from=ngompa13@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SpkNX174Jz2xKQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 01:17:46 +1100 (AEDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so601518066b.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 11 Dec 2023 06:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304262; x=1702909062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FeyufrOe65ZibAeQSako8BHcEODv5E1MPLsl6l5HtI=;
        b=jLbvw7KwE2YKjwF/PmhCcXLsb83nS6j4/2i3+FYyKY7Z2ivT9Om1OgrZKz2ypj+BIc
         4/0O2OZK50QEukFlctyWMROvOaV6DtmVsHzwW6ERQ6NXIE1IrWbQVVeyv0X3FGGe9VAv
         lMzM/KcRdx7QdKAK+SH+TYd7GKWKUBIYgQvu5U+ieZqZmy0kAWyreH0o7ohK8scuF7wv
         NhmpIR8lucCItLRWiFZjCuYkGUrFsjIeF7MeWE5TorAK27rueClxOY0hz2HtZdkvP56p
         eVlrPtjOhhR58j5U0PEOVf9RA8OI9JBHAtH7HI4EHlM/liCOGF55DMU7mnfZx7rdt4Ir
         eg1A==
X-Gm-Message-State: AOJu0Yw97q4dmHOfqf/QN4RVxDLfQYm4okfKIFLIbf1tTVe9bGFhX3tU
	AetQSreQXCCWGP/WSOfGfM2Hj+/0eoK1J6hY
X-Google-Smtp-Source: AGHT+IHUXVK0isjcCAYXzIcfwXvR+5KHrtKpw9ClzOCPBJBT0t3KuR9dMvSaVWwJTY53ajCkxHmbpA==
X-Received: by 2002:a17:907:3f08:b0:a1c:b3ce:25fe with SMTP id hq8-20020a1709073f0800b00a1cb3ce25femr2249702ejc.132.1702304261986;
        Mon, 11 Dec 2023 06:17:41 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a1b6cba8d20sm4817013ejc.122.2023.12.11.06.17.41
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 06:17:41 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so6328923a12.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 11 Dec 2023 06:17:41 -0800 (PST)
X-Received: by 2002:a05:6402:1a59:b0:54c:4837:a659 with SMTP id
 bf25-20020a0564021a5900b0054c4837a659mr2627320edb.70.1702304261586; Mon, 11
 Dec 2023 06:17:41 -0800 (PST)
MIME-Version: 1.0
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
In-Reply-To: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 11 Dec 2023 09:17:04 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_TFh9wF3K0JU2SPkskHB4A-KBkxVKKQ5yn1=PNSZQRdw@mail.gmail.com>
Message-ID: <CAEg-Je_TFh9wF3K0JU2SPkskHB4A-KBkxVKKQ5yn1=PNSZQRdw@mail.gmail.com>
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
To: Eric Curtin <ecurtin@redhat.com>
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
Cc: Colin Walters <walters@redhat.com>, Lokesh Mandvekar <lmandvek@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, Yariv Rachmani <yrachman@redhat.com>, Brian Masney <bmasney@redhat.com>, Daniel Walsh <dwalsh@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-unionfs@vger.kernel.org, Pavol Brilla <pbrilla@redhat.com>, Eric Chanudet <echanude@redhat.com>, Alexander Larsson <alexl@redhat.com>, Lennart Poettering <lennart@poettering.net>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, linux-erofs@lists.ozlabs.org, Douglas Landgraf <dlandgra@redhat.com>, Luca Boccassi <bluca@debian.org>, =?UTF-8?B?UGV0ciDFoGFiYXRh?= <psabata@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 11, 2023 at 8:46=E2=80=AFAM Eric Curtin <ecurtin@redhat.com> wr=
ote:
>
> Hi All,
>
> We have recently been working on something called initoverlayfs, which
> we sent an RFC email to the systemd and dracut mailing lists to gather
> feedback. This is an exploratory email as we are unsure if a solution
> like this fits in userspace or kernelspace and we would like to gather
> feedback from the community.
>
> To describe this briefly, the idea is to use erofs+overlayfs as an
> initial filesystem rather than an initramfs. The benefits are, we can
> start userspace significantly faster as we do not have to unpack,
> decompress and populate a tmpfs upfront, instead we can rely on
> transparent decompression like lz4hc instead. What we believe is the
> greater benefit, is that we can have less fear of initial filesystem
> bloat, as when you are using transparent decompression you only pay
> for decompressing the bytes you actually use.
>
> We implemented the first version of this, by creating a small
> initramfs that only contains storage drivers, udev and a couple of 100
> lines of C code, just enough userspace to mount an erofs with
> transient overlay. Then we build a second initramfs which has all the
> contents of a normal everyday initramfs with all the bells and
> whistles and convert this into an erofs.
>
> Then at boot time you basically transition to this erofs+overlayfs in
> userspace and everything works as normal as it would in a traditional
> initramfs.
>
> The current implementation looks like this:
>
> ```
> From the filesystem perspective (roughly):
>
> fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs
>
> From the process perspective (roughly):
>
> fw -> bootloader -> kernel -> storage-init   -> init ----------------->
> ```
>
> But we have been asking the question whether we should be implementing
> this in kernelspace so it looks more like:
>
> ```
> From the filesystem perspective (roughly):
>
> fw -> bootloader -> kernel -> initoverlayfs -> rootfs
>
> From the process perspective (roughly):
>
> fw -> bootloader -> kernel -> init ----------------->
> ```
>
> The kind of questions we are asking are: Would it be possible to
> implement this in kernelspace so we could just mount the initial
> filesystem data as an erofs+overlayfs filesystem without unpacking,
> decompressing, copying the data to a tmpfs, etc.? Could we memmap the
> initramfs buffer and mount it like an erofs? What other considerations
> should be taken into account?
>
> Echo'ing Lennart we must also "keep in mind from the beginning how
> authentication of every component of your process shall work" as
> that's essential to a couple of different Linux distributions today.
>
> We kept this email short because we want people to read it and avoid
> duplicating information from elsewhere. The effort is described from
> different perspectives in the systemd/dracut RFC email and github
> README.md if you'd like to learn more, it's worth reading the
> discussion in the systemd mailing list:
>
> https://marc.info/?l=3Dsystemd-devel&m=3D170214639006704&w=3D2
>
> https://github.com/containers/initoverlayfs/blob/main/README.md
>
> We also received feedback informally in the community that it would be
> nice if we could optionally use btrfs as an alternative.
>
> Is mise le meas/Regards,
>
> Eric Curtin
>

Adding linux-btrfs@ to the discussion, because I think it'd be useful
to include them for what handling btrfs as an alternative to
erofs+overlayfs would look like.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
