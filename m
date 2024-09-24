Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFF9841F0
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 11:22:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCZBh592Cz2yjR
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 19:22:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727169738;
	cv=none; b=ZdXiuyG6FAdtsZKr1AVOFM1usATQ5xSOy45++mQ1y9uQvxABiU90t0SHFiPUak5ZfP5vXDctQd3eJAE+u1n5HqnWwecB6sISQAVxQF/8zPSW1URg8iCHVyxLysHs4f3xXTPD2fKu4kaBvficdRH4wT8MO/zdLBjhAtjQTSvQPgYMnGiy4u6AHTC9Pli8dwu9KOqZ82+mngcYS6KJnM1Gc0DdugDQafO180TV7+cl7D5e3Jh1M4VO9j6LWPnYTp27rwDBlYxU3YI8ggpV18G9axf3SfuGgCiYU2QG8CulifFZAaqhC2jF+EFmEUN9s+Zvcz52hytVS/csNNC97XeI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727169738; c=relaxed/relaxed;
	bh=ezXFARLli0XopvazaZI4WJPLJgg9ymKuou4RbS/PT28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brQp8Ge9K17VOMm8N7Ts6PoaPabgZreii0NSDyiAT4Z293c3GGmipzJemubvw+4UJYqTVT13uT1qRT5W8/5ksgBqvMGc4RbzmoWLpKP7aS3RP9EIxcsRwAkmWoSBcqwV84gW8eYR7cuBqTWRFfxAwmpmUmtmmjQcZ7yGmVNzpP5i1T1GHyfzf+cGboOGrQX73+M+XrvkYsr7O5fiAuDK4Jwtndg8Jk9//Tzo12X9z1m3EspXb4oUw4pgpv+nuy6LDHZwHluWukk0LlWeMvcCrJFR3vjmyV5X5L8ewdGllTa2TIscAvannjFxdaA23a9S3EDtYD8wVfruiDdZy8JlkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.128.182; helo=mail-yw1-f182.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.128.182; helo=mail-yw1-f182.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCZBc6v2sz2y8X
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 19:22:16 +1000 (AEST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ddd758aaf4so38128827b3.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 02:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169732; x=1727774532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezXFARLli0XopvazaZI4WJPLJgg9ymKuou4RbS/PT28=;
        b=gjh/kaeWA6I/TRGTHOGnhP1yC9yV++t3n/fjHn+t6NxvehPAAG/KtTCAG9VSaD++1W
         QeV75wo9fYWTa5YbLDMvoL8PmhocCSP3YGPT+JC31VPSkpEyruTAbuJAGfALgV8+Wztg
         2OEBbKHrvsV8ln2/Em1HSg0WhSqERBbDnZ4YXjsAiMFOumToiJi+1MfuqzLwhegmUgxa
         AQayDxRN4oBexFeyxxOu6cleZa8a2Sgx1dVUwsaTlikaIiP/Z9D8E1LQTo87HW3tb3rz
         t/JLHV2XYjodUmFMFOd7MTSdCVRwc7CWUICay8SWMhmzTyEDH772ucwQsOgu4AAcH9zi
         GjoA==
X-Gm-Message-State: AOJu0YwRdaz+yLBK0+Y6lxiFFCfxiQMQ1HU7UQyyudx9dNxHjCgmfN4n
	L8mtMRKAksS97rfnGJde+sTG3VM+gfsdpmZ9ZtAoMkULAcj/ZHkHz7MrR6O+
X-Google-Smtp-Source: AGHT+IFOu/6seHqsu9WJN/LhPlDLNuxoymnRm6xcIrGgWf9SN9ZKf0py1fYZ6MDJH784fVuJP2vJoA==
X-Received: by 2002:a05:690c:62ca:b0:6e0:12e:e470 with SMTP id 00721157ae682-6e0012ee6ccmr105685897b3.25.1727169732337;
        Tue, 24 Sep 2024 02:22:12 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d27d051sm1871967b3.110.2024.09.24.02.22.11
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:22:11 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ddd758aaf4so38128647b3.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 02:22:11 -0700 (PDT)
X-Received: by 2002:a05:690c:fc1:b0:6e2:ffd:c123 with SMTP id
 00721157ae682-6e20ffdc6ffmr10422617b3.7.1727169731405; Tue, 24 Sep 2024
 02:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Sep 2024 11:21:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
Message-ID: <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

CC vfs

On Fri, Aug 30, 2024 at 5:29=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
> It actually has been around for years: For containers and other sandbox
> use cases, there will be thousands (and even more) of authenticated
> (sub)images running on the same host, unlike OS images.
>
> Of course, all scenarios can use the same EROFS on-disk format, but
> bdev-backed mounts just work well for OS images since golden data is
> dumped into real block devices.  However, it's somewhat hard for
> container runtimes to manage and isolate so many unnecessary virtual
> block devices safely and efficiently [1]: they just look like a burden
> to orchestrators and file-backed mounts are preferred indeed.  There
> were already enough attempts such as Incremental FS, the original
> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> for current EROFS users, ComposeFS, containerd and Android APEXs will
> be directly benefited from it.
>
> On the other hand, previous experimental feature "erofs over fscache"
> was once also intended to provide a similar solution (inspired by
> Incremental FS discussion [2]), but the following facts show file-backed
> mounts will be a better approach:
>  - Fscache infrastructure has recently been moved into new Netfslib
>    which is an unexpected dependency to EROFS really, although it
>    originally claims "it could be used for caching other things such as
>    ISO9660 filesystems too." [3]
>
>  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
>    enhancements.  For example, the failover feature took more than
>    one year, and the deamonless feature is still far behind now;
>
>  - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
>    perfectly supersede "erofs over fscache" in a simpler way since
>    developers (mainly containerd folks) could leverage their existing
>    caching mechanism entirely in userspace instead of strictly following
>    the predefined in-kernel caching tree hierarchy.
>
> After "fanotify pre-content hooks" lands upstream to provide the same
> functionality, "erofs over fscache" will be removed then (as an EROFS
> internal improvement and EROFS will not have to bother with on-demand
> fetching and/or caching improvements anymore.)
>
> [1] https://github.com/containers/storage/pull/2039
> [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=3Dw_AeM6Y=
M=3DzVixsUfQ@mail.gmail.com
> [3] https://docs.kernel.org/filesystems/caching/fscache.html
> [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
>
> Closes: https://github.com/containers/composefs/issues/144
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks for your patch, which is now commit fb176750266a3d7f
("erofs: add file-backed mount support").

> ---
> v2:
>  - should use kill_anon_super();
>  - add O_LARGEFILE to support large files.
>
>  fs/erofs/Kconfig    | 17 ++++++++++
>  fs/erofs/data.c     | 35 ++++++++++++---------
>  fs/erofs/inode.c    |  5 ++-
>  fs/erofs/internal.h | 11 +++++--
>  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
>  5 files changed, 100 insertions(+), 44 deletions(-)
>
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 7dcdce660cac..1428d0530e1c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
>
>           If you are not using a security module, say N.
>
> +config EROFS_FS_BACKED_BY_FILE
> +       bool "File-backed EROFS filesystem support"
> +       depends on EROFS_FS
> +       default y

I am a bit reluctant to have this default to y, without an ack from
the VFS maintainers.

> +       help
> +         This allows EROFS to use filesystem image files directly, witho=
ut
> +         the intercession of loopback block devices or likewise. It is
> +         particularly useful for container images with numerous blobs an=
d
> +         other sandboxes, where loop devices behave intricately.  It can=
 also
> +         be used to simplify error-prone lifetime management of unnecess=
ary
> +         virtual block devices.
> +
> +         Note that this feature, along with ongoing fanotify pre-content
> +         hooks, will eventually replace "EROFS over fscache."
> +
> +         If you don't want to enable this feature, say N.
> +
>  config EROFS_FS_ZIP
>         bool "EROFS Data Compression Support"
>         depends on EROFS_FS

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
