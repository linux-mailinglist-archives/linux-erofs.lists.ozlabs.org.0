Return-Path: <linux-erofs+bounces-426-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84089ADBD66
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 01:11:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLm2x06nmz305n;
	Tue, 17 Jun 2025 09:11:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750115480;
	cv=none; b=dAvUrJIHCgv30U5cZ4pl9w3VLsyoQ8tDrItWVk2CT5l3YFF1IHVcYJbLM60wmhNkegu44vJC8zaZjaaB07c3e8HAnp+PiB5Z2lbchZVfCbJQ6GSf75FcubIHmGbqEwuG1j4AlZYuiWeYOR13BClZMYCCp4HPnFnrbfhygrHuLrC+2Ei48s1Hh7wJ7YIggM3nAwWB4HWc12Y0j2yq1lbo6brDCgRQQbLe09jvnfjmJ/1vQHpTvIlbHdjDdSa1wQK6qvd1PvPx35s4j8gCMl0ZrNmWSRt0jF1xhYfAGrkh+OStu2+8BTraRQ7QEqFynopCmpHaXhLpG+R1STNzv8KiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750115480; c=relaxed/relaxed;
	bh=WbjyFa1lEmpjeO0fSo1gdi8l5MsWaLjra/L669ygfQY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jX6OegJRLDzZwrhuu+SgAjzGdt1+H2FrC/jbF01+TVn3o5lfTC1hLOJ3JK7O4fCQUv9sdMh/s0YvoaZGJCUTuAZc5qxF5pN27n+3CtNleGfWzZPzWT1282MDzjTmh8OOBu+gXYbEY3E+09o54X27a3JrYG03hKBkF/2AxTOD2x/RfaJRJ6vUZQ08TMyIsJj2Gj8L1eCm8JzcfwbgyZ5oJ7Cj51Qrym5wFmhVUyvEGuTM8MvvhBSxDaILvsCh5JPUV+VuhdDhU0EQS6UsxErknEuCsi83Q8F3YOzf3ry0SlCZ/Hkg67TexOfNWCbQXpVcMrGrifMAZIB7z4+RCvc4rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ZWFIShO/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ZWFIShO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLm2v35dpz301n
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 09:11:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A3062447EE;
	Mon, 16 Jun 2025 23:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210E3C4CEEA;
	Mon, 16 Jun 2025 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750115475;
	bh=f92kylcTcgjxPjPuigrD0gWIhxIBT4jMyjAYbJx2fgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZWFIShO/XryFzSpjTSsOpPReKk7MGg3LaJS+8VXbd/Sv0l3pkMferPDaEDw5h7t/5
	 TXCAWyMhImwvLfVbY+RFN3BVnPd8HICJ3ykvMXc1pH9OWRmJr7YNN1rWZZcClmJua5
	 wc8/ODhsb5I7ekSoYglMpTbL4//+BGhwsrmpxvDU=
Date: Mon, 16 Jun 2025 16:11:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe
 <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Eric Van
 Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, "Tigran A . Aivazian"
 <aivazian.tigran@gmail.com>, Kees Cook <kees@kernel.org>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, Gao
 Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
 <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep
 Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Namjae
 Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA
 Hirofumi <hirofumi@mail.parknet.co.jp>, Viacheslav Dubeyko
 <slava@dubeyko.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Mikulas Patocka
 <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>,
 Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Ryusuke Konishi
 <konishi.ryusuke@gmail.com>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, Zhihao Cheng
 <chengzhihao1@huawei.com>, Hans de Goede <hdegoede@redhat.com>, Carlos
 Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro
 Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro
 Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org,
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
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 00/10] convert the majority of file systems to
 mmap_prepare
Message-Id: <20250616161111.74e10321c4c421674f78d689@linux-foundation.org>
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
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
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, 16 Jun 2025 20:33:19 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> I am basing this on the mm-new branch in Andrew's tree, so let me know if I
> should rebase anything here. Given the mm bits touched I did think perhaps
> we should take it through the mm tree, however it may be more sensible to
> take it through an fs tree - let me know!

It's more fs/ than mm/ purely from a footprint point of view.  But is
there any expectation that there will be additional patches which build
on this?

I'll scoop it into mm-new for now, see what happens.

Minus all the cc's.  Sorry ;)

