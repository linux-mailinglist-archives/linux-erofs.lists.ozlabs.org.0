Return-Path: <linux-erofs+bounces-425-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4B7ADBD46
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 00:54:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLlgB5nCyz2xRv;
	Tue, 17 Jun 2025 08:54:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750114454;
	cv=none; b=cuN30MI7WrO0/wVnajAWr4mrbhSiOqPWauq6UnKwEoZLLR2fHjnV+h5FkqmavowQB+qBFgjBggSQ/h9zC9d2iGvbnfO9JHJs8yH71G4+gn9zGNo1bjGxrhZj2VTckDnq4MBj5SCipLi9lhQDPfAloX2kHqt+9VBZbzOMU8ky91tK42spb+j/MJD5DgDfuoDu3B3eD/yBqT8GlD3OICIONb8+tKqVz1SudeGaLuFmkra6HCX04Qu2aaG1mZRGZjF6m0rPHoBgU6QNL3M34QvDvsNcWQdGtiPOr4moTByf8RQJzPNhtUgV/74terNfUAZNJqaRMS4EaBTNbM6t3Qf1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750114454; c=relaxed/relaxed;
	bh=/MQsD6la/BSX1QuayTipEXhf37o+C5JvtM3N1DgVBC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgM9vT3OfgzV42IQ4E7KSbDGHP1XM45Jo89hblDgBHZqqYxNe1mDCs4QI+poWhQ2adFHIcjDzeDSQA/mpTxVuuu5IQHb09vMFu9eepg+AALq/7osCi+EjJmI17R6FnrpJfma2IOaV9Vq/REWMK2H+AE8KSz9tYZ8cGE/7O0HkmNA03oQq7C3YDpZrbjelJUUdvv+FLfh5ql3BO6X6r9rXW5slMTK/jHu/Fym8dcgmCxn9DW8ukUaicA6kewqsbTwenjsAsips/Y0GIGICpDJaYGzULqhoB/+zu/GxBurFIhsqm0ngGxTbW/0xNZ+ZzhlCoj3qYVUDRyPPgR62s6QGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p9LuBOmF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=dlemoal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p9LuBOmF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=dlemoal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLlg95qXZz2xQD
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 08:54:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 88E3A629DC;
	Mon, 16 Jun 2025 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F658C4CEEA;
	Mon, 16 Jun 2025 22:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750114450;
	bh=2rQ4MWMNuiiZXr3ruKby+3pF9PtUetUIutSjWGs52xQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p9LuBOmFGkwzRdPq0c3k3DFo+Gg7PbA5ztEVsDN9YZvn/BtbR0RubCEEUAupc/0QN
	 UyKsXWg+3Xgr8jYaXCDMYIX9AMo3NmXmNJWlhYEhfQb2Sm0ZC+2euqRHnrYZxtOuoI
	 /XOGCT4NNqf3QLkRtC5atg5JemfK28tCQYDxQ+vvt7VJIHaxKtebm4/Pva1Y9ypu3C
	 0i5AHJz8+318CUMsMSF8zAEbryPRnLo/KnKQMO3Ip+RltAyo1TepCJSxqJg7VUGaup
	 0RxiaVHPlYYqHNPaSdRNrmN5q1z0dDh0yP0RcMExF7vaS/owYzg4U/4qGi5HRJ5JK3
	 4Jr+e8uabprHQ==
Message-ID: <60615f31-7a58-4336-adaa-129408c90000@kernel.org>
Date: Tue, 17 Jun 2025 07:51:56 +0900
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for simple
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe
 <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
 Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Zhihao Cheng
 <chengzhihao1@huawei.com>, Hans de Goede <hdegoede@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
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
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 6/17/25 4:33 AM, Lorenzo Stoakes wrote:
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), the f_op->mmap() hook has been deprecated in favour of
> f_op->mmap_prepare().
> 
> This callback is invoked in the mmap() logic far earlier, so error handling
> can be performed more safely without complicated and bug-prone state
> unwinding required should an error arise.
> 
> This hook also avoids passing a pointer to a not-yet-correctly-established
> VMA avoiding any issues with referencing this data structure.
> 
> It rather provides a pointer to the new struct vm_area_desc descriptor type
> which contains all required state and allows easy setting of required
> parameters without any consideration needing to be paid to locking or
> reference counts.
> 
> Note that nested filesystems like overlayfs are compatible with an
> .mmap_prepare() callback since commit bb666b7c2707 ("mm: add mmap_prepare()
> compatibility layer for nested file systems").
> 
> In this patch we apply this change to file systems with relatively simple
> mmap() hook logic - exfat, ceph, f2fs, bcachefs, zonefs, btrfs, ocfs2,
> orangefs, nilfs2, romfs, ramfs and aio.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

For zonefs,

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

