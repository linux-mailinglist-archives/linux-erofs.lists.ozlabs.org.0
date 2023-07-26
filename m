Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC2B762845
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 03:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690335592;
	bh=g4+spZWgq0eS9irqfihzysgfAABYfYXXmt6SNBBeIWA=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=L2C9I0ry8eHTKiETDXomplYvbQMbQ9HhKwixqM7a8PoDJn8XVB7K4c3BO0oeNTZP+
	 PE/2HIXmoLmu7RQTjA27VfnXOCyKP4zw1mhZ01BUIpy7ktHXHMuD3pgafF3Mkr+JX+
	 ahH4ene0VKkNcq+WGf/Sdc7WOgvE/6EZW0r6w7qJ7AxJss6z0HjKhhsuSaOvhbjgzA
	 UqvMDa9aC2szPIrgBGbZ0PyMDsAGPGbZZtdCftghPJ3GFoKMQB2Qj7YSKMWnSWqR4u
	 /lRd3gVJWcbJnuv1QI+AfOez0y5mVy1S7NzMaJqFCBxZodtgUfv+LNXeO8l14LwyNb
	 iYhTRL/KxDqsQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9c5h4C2lz30N8
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 11:39:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=MZxYT2Md;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com; envelope-from=hughd@google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9c5Z4fWtz2yTv
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 11:39:45 +1000 (AEST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583b3aa4f41so47257877b3.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 18:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690335578; x=1690940378;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4+spZWgq0eS9irqfihzysgfAABYfYXXmt6SNBBeIWA=;
        b=b0YaCBmLdWhDCDBTzZ+qNs84s8sUqLXIwkAxDWro6OhdBb8YZJBkZkNmcfezOogFeV
         710VMZqmLlkzdUA8Uuk7JUfMg6eAEdPvoVeZjIKKd0RaqtTVGZXVjubZkA0F2AHs6/bd
         sZWWJ6boQGJth2i2Ua65u1sn33hwUUBQI13NuO6WmkpgxeyRI0y1vrcPxPP3IePoyLht
         Mtm/1k53tsqsgiiCh5dzE1huVq2uVTuSJQH6Z5kkQj2KiVG8z2D/6VmKTiXr1wNICa5b
         9GCNOOD2Ug2mTUpvlJcZiCu+2EQACujYS1WFaTrZaA/2CyrJQ94enGyvsra+TueHLIbQ
         5a0w==
X-Gm-Message-State: ABy/qLbQl/yZSg4TrCYvcg/vD+7VmaqPRAxNUYyf3U4/SqscGfDnHu8B
	md7mrBxkcUI5mSa/eOMNQN625A==
X-Google-Smtp-Source: APBJJlHxqCs0/k9opPHZr1oFjC/IjLn2NWFjtEyuaFY5bDdVyDOg3sTAz2vkUnxY9z5liUX1UEynKA==
X-Received: by 2002:a81:46c3:0:b0:56d:2189:d87a with SMTP id t186-20020a8146c3000000b0056d2189d87amr821699ywa.15.1690335578030;
        Tue, 25 Jul 2023 18:39:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s10-20020a5b044a000000b00c654cc439fesm3165326ybp.52.2023.07.25.18.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 18:39:37 -0700 (PDT)
Date: Tue, 25 Jul 2023 18:39:25 -0700 (PDT)
X-X-Sender: hugh@ripple.attlocal.net
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v6 3/7] tmpfs: bump the mtime/ctime/iversion when page
 becomes writeable
In-Reply-To: <20230725-mgctime-v6-3-a794c2b7abca@kernel.org>
Message-ID: <42c5bbe-a7a4-3546-e898-3f33bd71b062@google.com>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org> <20230725-mgctime-v6-3-a794c2b7abca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
From: Hugh Dickins via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hugh Dickins <hughd@google.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org,
  linux-f2fs-devel@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Anthony Iliopoulos <ailiop@suse.com>, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.de
 v, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 25 Jul 2023, Jeff Layton wrote:

> Most filesystems that use the pagecache will update the mtime, ctime,
> and change attribute when a page becomes writeable. Add a page_mkwrite
> operation for tmpfs and just use it to bump the mtime, ctime and change
> attribute.
> 
> This fixes xfstest generic/080 on tmpfs.

Huh.  I didn't notice when this one crept into the multigrain series.

I'm inclined to NAK this patch: at the very least, it does not belong
in the series, but should be discussed separately.

Yes, tmpfs does not and never has used page_mkwrite, and gains some
performance advantage from that.  Nobody has ever asked for this
change before, or not that I recall.

Please drop it from the series: and if you feel strongly, or know
strong reasons why tmpfs suddenly needs to use page_mkwrite now,
please argue them separately.  To pass generic/080 is not enough.

Thanks,
Hugh

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  mm/shmem.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b154af49d2df..654d9a585820 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2169,6 +2169,16 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +static vm_fault_t shmem_page_mkwrite(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	file_update_time(vma->vm_file);
> +	inode_inc_iversion(inode);
> +	return 0;
> +}
> +
>  unsigned long shmem_get_unmapped_area(struct file *file,
>  				      unsigned long uaddr, unsigned long len,
>  				      unsigned long pgoff, unsigned long flags)
> @@ -4210,6 +4220,7 @@ static const struct super_operations shmem_ops = {
>  
>  static const struct vm_operations_struct shmem_vm_ops = {
>  	.fault		= shmem_fault,
> +	.page_mkwrite	= shmem_page_mkwrite,
>  	.map_pages	= filemap_map_pages,
>  #ifdef CONFIG_NUMA
>  	.set_policy     = shmem_set_policy,
> @@ -4219,6 +4230,7 @@ static const struct vm_operations_struct shmem_vm_ops = {
>  
>  static const struct vm_operations_struct shmem_anon_vm_ops = {
>  	.fault		= shmem_fault,
> +	.page_mkwrite	= shmem_page_mkwrite,
>  	.map_pages	= filemap_map_pages,
>  #ifdef CONFIG_NUMA
>  	.set_policy     = shmem_set_policy,
> 
> -- 
> 2.41.0
