Return-Path: <linux-erofs+bounces-2048-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2714D3B756
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 20:33:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dw0x350J4z2yql;
	Tue, 20 Jan 2026 06:33:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768851191;
	cv=none; b=FkwxA4idd4l/5oU66MzqTgN1Uw7EXG5UawqmLqqieM25hP7TSNbA02gdRLQCI+Ef02rB22e5Hb94bMn8WH21l1xzzbwMzdlfl4bKHjNu/+SgsWJ4wIFehkOmScjP/Ho8N5ad33QaAE4hoC62D2A91hhf/QilUSaDz/lHjOF2j6lJjePklh1koNvL1Mg3s/J4xoDUoryjcJf7yBz0/GzqfU9RxqKoDoJjS6upFB6zuFINHoKbT6M2m05yJeJcG4Oo4jiIP+Uldk9nejwr15S5IItdt/Lfy/yAO5UydG/i8vKXIoTia6/cHE0PqoqjTznO4ymXCg87RjoJLKEiVneGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768851191; c=relaxed/relaxed;
	bh=AZwi0Zad3bgCaZNerswcpSdop4bARwqwJTbYnPcBpR4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RvEdBGuNN+SKhcYUcTwItjZ08EBKfkAwBYO1q9bsxfmmDbeXD+5SpUXBQEt2uuYJGvL4IpM04NQD32IZCb5YssH3V9n5QfjHt9XoIZSHJe4+dzeukm6yZqirVHPHXFXJ1WCoWgrFt8zAoLGOBdZ0TBth241qmdtbmkewv+bvxujfmTD3l2FbU4BtYXIRTGn5EdmlfQsDcyB68p2tKv5/zqp69vcwj4ooRrX+bIkR9A4biuGeHe1Qk8xsPiFhHAGprbKtXqqhHSyjPSLPF5sED8pMloGjH+O/vGZjceV9bVm0xgmP0dTeT0fCi//A2ut/j4JHsBa0HpxZrGg863nWUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Jwiw8ZqX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Jwiw8ZqX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dw0x1727dz2xSZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 06:33:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CDD98600CB;
	Mon, 19 Jan 2026 19:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD0EC116C6;
	Mon, 19 Jan 2026 19:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768851186;
	bh=PRVJ16ccr6KBA8Uf9ujjZQyURMiuVIb1RLBxOuAUaAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jwiw8ZqXymRq+wiALadlAbpDLsKCve1hI4wsWYVAZMJ9n7yGkAWX7+yzeWf1ds/2Z
	 npx4R/EHTL5QWpEUX5ULuLD87ON54PXj60lr7sfRkY+Nea7RWwEvR00fj1d8bhjzWn
	 nMJ+Jzcn2nBqy0YkA+hgqmk+zw4e9UPb0gVqDV24=
Date: Mon, 19 Jan 2026 11:33:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Christian
 Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew
 Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise
 <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mike
 Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
 <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, Carlos Maiolino
 <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
 <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh
 Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Zi
 Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
 linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 00/12] mm: add bitmap VMA flag helpers and convert all
 mmap_prepare to use them
Message-Id: <20260119113302.76b21eb8be2f9d0bb076446d@linux-foundation.org>
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, 19 Jan 2026 14:48:51 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> We introduced the bitmap VMA type vma_flags_t in the aptly named commit
> 9ea35a25d51b ("mm: introduce VMA flags bitmap type") in order to permit
> future growth in VMA flags and to prevent the asinine requirement that VMA
> flags be available to 64-bit kernels only if they happened to use a bit
> number about 32-bits.
> 
> This is a long-term project as there are very many users of VMA flags
> within the kernel that need to be updated in order to utilise this new
> type.

Thanks, let's give this a run in mm-new for a few days, see if that
helps shake anything out.  I didn't add [11/12] due to a significant
merge clash, but it compiles!

