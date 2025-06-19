Return-Path: <linux-erofs+bounces-473-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF6AE0C12
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Jun 2025 19:48:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNSkt3sgrz2xck;
	Fri, 20 Jun 2025 03:48:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750355302;
	cv=none; b=QXVV3IdWsTXP86fMbtkE3e0emG8q78xnOnLAcCf6cZNcg1w5Yq+UW47iOUp9WIk/sBqQoD0Hsvb2jb7zcP+ZkcoaAeahdK4uTv6SlfCzgyPZfJR8FE3+StmMKJVDiTb6LRSoe+NI1lipXz5zDkFSjMb0lvRUeKR/iBumxutx/VKk3ldn4l0T6LQFd2ecVxVLGuX++FclX6+SuQNUQLiNR3pudUYTOqOHZVK1W1H+TjUx5PJYmE+LDjGBhrPco/SPSFSGhE1cAltGnkQQ51mm1AT2xLuTOv7olwCIeAqRAkFtzqLysy1W49gWagMvQ2L+Imo9IGnXf4hSxU2jGCOJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750355302; c=relaxed/relaxed;
	bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS94pShE0CCafRg7MWTn+4HCVJOchbuQjBzc79JisA/qhliyzOg5cm05qa16MhbBT7Wy7QzPB0pt4C+8ZKoEvQX3cREg/HxWpUqnyV361p0ls0r2QgzoQER4dkD6lkg7XwZ7nz3qSJ/mlg7GFQTQriqnStCEUaCTu/P4NFak0WMsGd9Nk0I9VCc4SLd68NNr/SgxWI4fC+1t2XDQOw0uz98Wz7jUyTs9UvyrHfmI4/gf2AcDZz0xIU5MAcfjlocBwSHxSWDgJ4tl382ahKOD+KsIzRQIvLj03Epd4Jyd0x8W+MrncEcyf/9SEW0e1TCtTU3qHXQm/BhIT9VwZ71xmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GWZ4eS7G; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=konishi.ryusuke@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GWZ4eS7G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=konishi.ryusuke@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNSkr3MFWz2xS2
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Jun 2025 03:48:19 +1000 (AEST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-32b435ef653so9609931fa.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Jun 2025 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750355295; x=1750960095; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=;
        b=GWZ4eS7G8AMh5hxHslzLjuqMtcsZRE82esEPBxttBetSxaEUrK3i8ihBxpMEMXgWO5
         ZUlssCTGvR86X647YktaY0vJ5TqFPdbmfASZJLaC1qHf5Y4v14RciiCJKzZwrMtHoIjR
         OeY2oqeLvACDR2d8xf8yH72JiQgOY63qWqXArEk+02CDLKIIm+4fmW8kS9xyYhV1fSLd
         V067LHdiuZfe59dKG7OlQVvHB3c1ZPbMRa+mATw/1AGoWApNr1Tb/4weq539qXnS8vVf
         YYP9sOO7H6Ajc/Cj1pAvk0RzpOcATGBoZ4qVuNFe83PtZ+PPsFjLmls6gSg9uAHSvBuO
         +oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355295; x=1750960095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=;
        b=Cyo469JkNw6xREyYHD0i7K42dx+60Y3J94he3fy27brx/alKwR4cEnMze31wC8BvN+
         aLSVIspnMRqCXb+s71AtVtUsSvDzfFEx7NAiQRfrfgqZT18vq6c/Hli5p2cnP9ZuNqvU
         JX2MMHK/A1xw4wfIfaDedjZm3xmWvfrIF8wpHf5o+fe4jkx5bF0SG8hAv2VH4aMuQXLo
         L6IaUylbY4DoSeAfsjffUFWXr3OQ9ltO9UXE3qQ1naGm8TrTShmKtWKRA52+SSP3vsGS
         4+HjoyeE2G4EDUG4WZRRr9VSG1I1rJbUD/sv/P/HvtFAQKI71TrKE5rFUa+u2gpr7Znk
         mp8g==
X-Forwarded-Encrypted: i=1; AJvYcCXyPJBpp0N/6dr4cXPeZgBzRfGWqCUialoTSZBygpGRcTuXTya4fZHhsy1kzDOE5kF5QjBZx4O4P5tcPA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4FRgv0KHxWioqFY/STSu+yJ6nqWZVa0ix2eKLULDk5ZXlAapc
	ThljEAEQEHQlpnaJ4N8+WrocCXe+aVgq4AKf5hMMdbJL5jKICvn0oRbeu57OJuuYso5hgcJm9tJ
	qYlKGsdqPuKWbNYT99M6vQhT3LqxhbF4=
X-Gm-Gg: ASbGncuvzkRMjbFq/AvOsvOLKihpn8en/cSMpMWHLHs7RaG++qHxuc8NCPGHgYArZMU
	Ib4BnlyMOTVQ35INMyy5sX4WbuH6rrJxZPiJAihi6l97kM870d3KUTttjraCjnBrWivT2nB6GJt
	LPJ4ChpKf2nZ6WIw19DhmzxK+NKpOhGRTZf9UMBUqPdfePuTMjASyiL4wkQtfpcDRgSS4NSRY5K
	2FsIQ==
X-Google-Smtp-Source: AGHT+IGL41V3DbmFvBsWr3jGwFHfcX0duW69mbczpCAOINsa85ECUigYdfUlpWqgF++enxibRnhFFvr8Kxdp2WtP+R0=
X-Received: by 2002:a05:651c:2203:b0:32a:8297:54c9 with SMTP id
 38308e7fff4ca-32b4a3088bbmr63065741fa.8.1750355294494; Thu, 19 Jun 2025
 10:48:14 -0700 (PDT)
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
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com> <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 20 Jun 2025 02:47:58 +0900
X-Gm-Features: AX0GCFsRgomy43xV-Lv7Stfld1a1yqIyJ3-ysZ2OVO90S8cEE5UAjZMSvGqxZQ8
Message-ID: <CAKFNMom4NJ91Ov7twQ3AGT7PSqt5vN9ROrNHzfV53GHf=bK6oQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for simple mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>, Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Hans de Goede <hdegoede@redhat.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-mm@kvack.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, 
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, 
	devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, 
	nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Jun 17, 2025 at 4:48=E2=80=AFAM Lorenzo Stoakes wrote:
>
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), the f_op->mmap() hook has been deprecated in favour of
> f_op->mmap_prepare().
>
> This callback is invoked in the mmap() logic far earlier, so error handli=
ng
> can be performed more safely without complicated and bug-prone state
> unwinding required should an error arise.
>
> This hook also avoids passing a pointer to a not-yet-correctly-establishe=
d
> VMA avoiding any issues with referencing this data structure.
>
> It rather provides a pointer to the new struct vm_area_desc descriptor ty=
pe
> which contains all required state and allows easy setting of required
> parameters without any consideration needing to be paid to locking or
> reference counts.
>
> Note that nested filesystems like overlayfs are compatible with an
> .mmap_prepare() callback since commit bb666b7c2707 ("mm: add mmap_prepare=
()
> compatibility layer for nested file systems").
>
> In this patch we apply this change to file systems with relatively simple
> mmap() hook logic - exfat, ceph, f2fs, bcachefs, zonefs, btrfs, ocfs2,
> orangefs, nilfs2, romfs, ramfs and aio.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

For nilfs2,

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

