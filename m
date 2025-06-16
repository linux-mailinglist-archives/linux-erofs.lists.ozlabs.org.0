Return-Path: <linux-erofs+bounces-423-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C012ADBB26
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Jun 2025 22:28:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLhQr5rGBz2yMD;
	Tue, 17 Jun 2025 06:28:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750105700;
	cv=none; b=BYfmTvbSH9dr6r5oElKrE5Ffy/o7X8V2F4JvA5LAEgmN2SfU6KC2aDtQOGzHKfrOTP1SSi/Bfj7yGe9KULFp+pK+NA7RlMrWG7KilcF3FVgPS37X63sLUv6aAv9nWAI9NEjAmYQ16dy+QvF4nELw6jfgsxtPC2gfHFuZyXRfrqpAQ4CS5eXTcLQsxc0ZF7/bdOKbLRoibJtI/7vzK9PVptySFRyZs+QI+R852vljpQAvnC4U7LE1mnhbOWSy5Zgm4Y65wYb3oTpExZbDJNpBElGdqBCaEGo3EB9lHVilTS2OlT+JtgWypC1xUvYhratP2iOLddlqN8SyBEwfMROeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750105700; c=relaxed/relaxed;
	bh=rMTsK0YsjlB18wsT75a6evHrM3XMSVJTrFI3gzXouMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj8r9iBRRcRdnJRXGXeysnmNpWhCoe9z0tKBfoGAJzOUgTlk7uyWj8nmzkYY6JfP1F3Cp9rkaKZwosGoUqWhRxtHrokqv3x+kszvoaqUXSRSxGMgA/hqjXW71tu4OEjbMycI3r1nDA9KDe03vYCbRNLts1vm7cfjxaLMZiN/ZDSkpUSQt7b8fBnO4sAhUjGWtxmA+hqap84XNWzpooHruYZGv07yXpXGzB0T6KgRs5rjYDFbSW8xI+T0Fj9GEdWx8dg5Krh06bretlpL23uF51J5BT2+6h3C2z+44FvYU2w1kbm2SkWGdr+ANTWW+lVmYNsfBgvM8jII2X12unL3Kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=XSnCmY0M; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=XSnCmY0M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLhQl1bpXz2xck
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 06:28:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rMTsK0YsjlB18wsT75a6evHrM3XMSVJTrFI3gzXouMw=; b=XSnCmY0Ml7NLCrMRP4OfNwKCxm
	t3knyrRU4umUwqGsAQ78VDJwhklMHyppjzgkgSiDjEr1eDLbkdmMI1Ud09tK10NOTGSkVr9OAVdA5
	yeDW00x8GaS/9hTn/5iTIiI7ZEmOX2IYVaYsUKHT/a7Sh9XTAvxkYrLcfI6adjZOgVZ/EQ8izXpRS
	N7CyfmoYNKAXSZWjXkcw7dH2WIhiyXqdB2rcIWxw4KPMz9e5BecjG1NA5nrYsPuYwy5tj/ShXnUjZ
	Hx7i1JazW+vFcm5JpzfYFwz2+TREcWXzGJRoblKfrG12x8d/ZXuZZBMy93UQ4ahuLIE/06ESgJ7x2
	dKaQyh9w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRGPu-0000000GKxl-3X50;
	Mon, 16 Jun 2025 20:26:54 +0000
Date: Mon, 16 Jun 2025 21:26:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
	Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
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
	linux-f2fs-devel@lists.sourceforge.net,
	linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 04/10] fs/dax: make it possible to check dev dax support
 without a VMA
Message-ID: <aFB-Do9FE6H9SsGY@casper.infradead.org>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <b09de1e8544384074165d92d048e80058d971286.1750099179.git.lorenzo.stoakes@oracle.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09de1e8544384074165d92d048e80058d971286.1750099179.git.lorenzo.stoakes@oracle.com>
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jun 16, 2025 at 08:33:23PM +0100, Lorenzo Stoakes wrote:
>  fs/ext4/file.c      |  2 +-
>  fs/xfs/xfs_file.c   |  3 ++-

Both of these already have the inode from the file ...

> +static inline bool daxdev_mapping_supported(vm_flags_t vm_flags,
> +					    struct file *file,
> +					    struct dax_device *dax_dev)
>  {
> -	if (!(vma->vm_flags & VM_SYNC))
> +	if (!(vm_flags & VM_SYNC))
>  		return true;
> -	if (!IS_DAX(file_inode(vma->vm_file)))
> +	if (!IS_DAX(file_inode(file)))
>  		return false;
>  	return dax_synchronous(dax_dev);

... and the only thing this function uses from the file is the inode.
So maybe pass in the inode rather than the file?


