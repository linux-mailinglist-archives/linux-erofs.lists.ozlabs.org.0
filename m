Return-Path: <linux-erofs+bounces-1783-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57AD07F16
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 09:48:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnb6F6ltXz2xc8;
	Fri, 09 Jan 2026 19:48:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=116.203.167.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767948533;
	cv=none; b=SBcacZXseCSw4l80r185cKn9Ok+9VHw5vRxpVXyT1OuVJZ9gUwJxyWFp1VUyQ7ks42lyIFdWG6Yy1o6NubVsBWgiQ/GvFh8lWbGw6UjshZIEc1pZhJRHIQbYJMKTC21eEGQv88akKtdU04vsaDmX4XZu9oAAe+FAii4H52ewe7Htns+xFXkC6odH7cDturjZgrc6bF6lzz/nCiRsHcYDdCv/wQKl9LSxBD/tzcUziOhTRTOM0ndOyM6z6qzyflAseES03ondnRbw3L2hCyWEndmWUiuw6HqgxUHkvI74nvwJ6cS8WEr5NPqtYVmUcIXwXRrRsHBNQFS8DpmAqX+GhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767948533; c=relaxed/relaxed;
	bh=hi6ZwA10nQeVVLVHSSKeYbeNuIjA/FZtJQ9gk2yneq8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=D9DgYZ6OWMi4lmkfjVXk9dG+Q6ZH1g/OvK9fq0v9Vc/s8+oyKWIcRBFdU+2tzooSYlNLSpyziC2CYb6ltGXKzNZ4vK6t65/Q6QpdO77HQLRkSlHhLpnh+x5Em8eml45MGTHIe0+qSsZOXoxV9hjD4P1ZEE0dVfmMjVf6kw/NGvjGYwpWCoMl9iLwy/N5q92GoWMUqIIbXoyvhBUnjOizcqZKDjJKuCevURNp+ypAwRMwHber0BKVWB622b8nDhfQCe3v49c66CC73F6zmwBq+WXE2T/Alb/mhc0n7u172CK0GpRMeFsBNBfslG18C306xDy1Mh4ww8B+0q4AvSQ+Xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=permerror (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org) smtp.mailfrom=nod.at
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Unknown mechanism found: ipv4:195.201.40.130) smtp.mailfrom=nod.at (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnb6D3Hsvz2xQK
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 19:48:50 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A047A29ABD6;
	Fri,  9 Jan 2026 09:48:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PY1yWc1jnPcz; Fri,  9 Jan 2026 09:48:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E0C0628F9E9;
	Fri,  9 Jan 2026 09:48:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BZO6SamqYTTM; Fri,  9 Jan 2026 09:48:45 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 30C7B29859D;
	Fri,  9 Jan 2026 09:48:45 +0100 (CET)
Date: Fri, 9 Jan 2026 09:48:45 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, 
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Anders Larsen <al@alarsen.net>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, 
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Jan Kara <jack@suse.com>, tytso <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, 
	Dave Kleikamp <shaggy@kernel.org>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, 
	Carlos Maiolino <cem@kernel.org>, hughd <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, 
	chuck lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, 
	Matthew Wilcox <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, anna <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-erofs <linux-erofs@lists.ozlabs.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	jfs-discussion <jfs-discussion@lists.sourceforge.net>, 
	linux-nilfs <linux-nilfs@vger.kernel.org>, 
	ntfs3 <ntfs3@lists.linux.dev>, 
	ocfs2-devel <ocfs2-devel@lists.linux.dev>, 
	devel <devel@lists.orangefs.org>, 
	linux-unionfs <linux-unionfs@vger.kernel.org>, 
	linux-xfs <linux-xfs@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	gfs2 <gfs2@lists.linux.dev>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	v9fs <v9fs@lists.linux.dev>, ceph-devel <ceph-devel@vger.kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	linux-cifs <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>
Message-ID: <393733638.88534.1767948525135.JavaMail.zimbra@nod.at>
In-Reply-To: <218403128.88322.1767944438487.JavaMail.zimbra@nod.at>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org> <20260108-setlease-6-20-v1-12-ea4dec9b67fa@kernel.org> <218403128.88322.1767944438487.JavaMail.zimbra@nod.at>
Subject: Re: [PATCH 12/24] jfs: add setlease file operation
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Topic: add setlease file operation
Thread-Index: Ijb4veyM6wDb0tIeqxd8skdz5qkIYBNsmijj
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,T_SPF_PERMERROR
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

----- Urspr=C3=BCngliche Mail -----
> Von: "richard" <richard@nod.at>
>> ---
>> fs/jfs/file.c  | 2 ++
>> fs/jfs/namei.c | 2 ++
>> 2 files changed, 4 insertions(+)
>=20
> Acked-by: Richard Weinberger <richard@nod.at>

Whoops! I meant to reply to the jffs2 patch...

Thanks,
//richard

