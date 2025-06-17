Return-Path: <linux-erofs+bounces-452-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FFCADCA40
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 14:00:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bM5680x8Kz30GV;
	Tue, 17 Jun 2025 22:00:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750161616;
	cv=none; b=J3zlkcZ/8QMj1oKlX0pDmEM2yqYM9O2P5ylP5N+T+ROurnt45kALZtkdatrfmhcOdIjhQ/fO3vNh1O5r7XODojV5i9gdflel3jCBUU0wC0BGCJrKqjYurWldY7O3q8bqOlxoegyOjHTqvTf6u4jxtzii9HSdmiD840shQATBbLvE18hgBjug/ayyKv/+cRsY5f0NamUHwsnYN481NiPndFW6g7Y/O3vJ5u7iWnDgJtz40vCUnPebraiSNMu3yQcDWSM9Q/yHAwkfY+jiRG2qMRyO3O3POXXQsgKGtLpVUdGQtTkDU8nK9Ma9hgguQNnLJR06vw2UVzL5Ps1wHhVwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750161616; c=relaxed/relaxed;
	bh=VadYNfxPDS9mWpWiEQHS/5/7snz8zXTvd9oaZpSDKWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLYBAoZolPhM0i5F2inea1RHdjB7Ck8RFWJwF31tSBl9nJo+RnAqunQAY0i10t/HK0zToMEyZS4W/H32fi0RYuQe2nL5+3M8SeF/tPD9dyt+ZV5dk9AMTDK1uz06SHBZvkAGSKwbJmRjt3u7hwXWvkxfs/qdoY5FqymzeH9Gqx2JW0HUSWk9f1CWG62PO1tBEq6m/+uTVusI2YnwzpsSl1ORwxvxJ9faJ6mkyHtbEig3bZYzL52fIRzs9Ek9tu9TU9zF/8m1YEinR5cNRtJlfD1A/SLq8i5UPRyHnXk9KvBo4mNWdQA7h2E7We2gL+O3C79+WKEwUi8uR2TYjHs5hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cbm6eSpO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cbm6eSpO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bM5670mf5z309v
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 22:00:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F92D49D8F;
	Tue, 17 Jun 2025 12:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F729C4CEE3;
	Tue, 17 Jun 2025 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750161613;
	bh=d7N8Br27sigUm6RwJ6QKDyuMIfLKb482gs0GJECdYqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbm6eSpOXnYTKVf24fD5wSecYeYAtaJSPLtzA/cg7YuA4PJRPYSNZqoHGrOB9vedO
	 xE+Kw4QDbA/4jdsP7oXbPhVrMP5XKHSj57b+LizHRuDadEPqGBM+ZxF2QhTJG4KKld
	 niMYuWEWwMHm5apCVpkqg1uA/sm57a3OJs6XP47Q03JuvcLdBMJ4BZLJME8mGFpquF
	 OAV54y1YNZFqwgygvgnolLyQkxdfAP1bT54VMRT4yd/LwvYOK0H78h2s/9FU+jHgJZ
	 /1P5yb/ScvLTgMkRASvu83CdtUFgXaGEFmmqSgC4JGFIOk41SmtzQEJEUL45wKXKIE
	 copUCuL9W6X/w==
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Tyler Hicks <code@tyhicks.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-aio@kvack.org,
	linux-unionfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	ecryptfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-um@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	devel@lists.orangefs.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-xfs@vger.kernel.org,
	nvdimm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/10] convert the majority of file systems to mmap_prepare
Date: Tue, 17 Jun 2025 13:58:21 +0200
Message-ID: <20250617-neugliederung-erarbeiten-58c2ad93db83@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454; i=brauner@kernel.org; h=from:subject:message-id; bh=d7N8Br27sigUm6RwJ6QKDyuMIfLKb482gs0GJECdYqY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQERqz1Wd3by3g/duuF6rmP/N/MPRV+t8Tf5qpaV67t4 jKOJ7rXO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaysIiRYfKb1+w2vf8O/mdg vPFO8PHqRzML+F0vTZYp4bqm1fwkeyXDP4PuJqblPl9UmcRtf/n65jge6ap97PLc+43T4+kid/k fMgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, 16 Jun 2025 20:33:19 +0100, Lorenzo Stoakes wrote:
> REVIEWER'S NOTES
> ================
> 
> I am basing this on the mm-new branch in Andrew's tree, so let me know if I
> should rebase anything here. Given the mm bits touched I did think perhaps
> we should take it through the mm tree, however it may be more sensible to
> take it through an fs tree - let me know!
> 
> [...]

This looks good. I fixed up the minor review comments.
Looking forward to further cleanups in this area.

---

Applied to the vfs-6.17.mmap_prepare branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.mmap_prepare branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.mmap_prepare

[01/10] mm: rename call_mmap/mmap_prepare to vfs_mmap/mmap_prepare
        https://git.kernel.org/vfs/vfs/c/20ca475d9860
[02/10] mm/nommu: use file_has_valid_mmap_hooks() helper
        https://git.kernel.org/vfs/vfs/c/c6900f227f89
[03/10] fs: consistently use file_has_valid_mmap_hooks() helper
        https://git.kernel.org/vfs/vfs/c/b013ed403197
[04/10] fs/dax: make it possible to check dev dax support without a VMA
        https://git.kernel.org/vfs/vfs/c/0335f6afd348
[05/10] fs/ext4: transition from deprecated .mmap hook to .mmap_prepare
        https://git.kernel.org/vfs/vfs/c/8c90ae8fe5e3
[06/10] fs/xfs: transition from deprecated .mmap hook to .mmap_prepare
        https://git.kernel.org/vfs/vfs/c/6528d29b46d8
[07/10] mm/filemap: introduce generic_file_*_mmap_prepare() helpers
        https://git.kernel.org/vfs/vfs/c/5b44297bcfa4
[08/10] fs: convert simple use of generic_file_*_mmap() to .mmap_prepare()
        https://git.kernel.org/vfs/vfs/c/951ea2f4844c
[09/10] fs: convert most other generic_file_*mmap() users to .mmap_prepare()
        https://git.kernel.org/vfs/vfs/c/a5ee9a82981d
[10/10] fs: replace mmap hook with .mmap_prepare for simple mappings
        https://git.kernel.org/vfs/vfs/c/a1e5b36c4034

