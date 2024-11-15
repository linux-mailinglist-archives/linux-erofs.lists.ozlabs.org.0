Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B463A9CF622
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 21:32:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqpbZ5MfRz3bWp
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Nov 2024 07:32:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=136.144.140.114
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731702729;
	cv=none; b=oYSXrrTDEz4RiDKpFYLnPY4Gal+cARP4h+XarSmtt8lVhoVz+CIwwh2y9XifCmOw3dKoN0T4GDP/4sqNn680vFUwttGak0q/uOOQXbUhHR2Ymgw3mNdfdMy8BtcvKuJqnwtvlV1wE/upRloVS4ujWXwWLqyaMoc/iHZ0SLQELn/nwdiZZMEyOkWUEqxdBxt1U91JlXnDkPNbX/AG4IN/0mWTQi5LCvoHUmXAFZ5tNrc8iAkp+pU6r6gJkbBcJ304vd4r8xjEs52U5nPsbVgLisQaGoRWMCTbWptqoiVLJs7hJOdeuMihQA8fTplYh140NrvK1Xan04AkHgX7djdO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731702729; c=relaxed/relaxed;
	bh=v5hJaYvL9y6KQTlCZ+gj9BUlS+HUfMaKtYKI2JbOETk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTeqhEBj3WTrQbtvneLuSuq5yE7I3wIQ61TnEHAYKmyHhou+zLlE3l4qRw26u3ZZ8ZtTYE1OPXXVIZzSqH5p7hAzun4pYGRuZO+IYQHqCAJop+lEhyKKMb7QnSJfO0DkSqV/H+1/aW2InhBmwPilLXEO9e/TQNTNaGgF85nvMvlS+I+TWnFHEKn/bl8pD3Epjo2fC/KDKi3xnu3FoYbPhp4QhT2h7VX/uIaRvsJc/Hc+0/dxLq4CCXdra3ZyvzgMhlc4nx99191BipJon/m22T2XKHjafFJnDPmocta7JfwpAMMmIOoFsXh+MLf46RFaT37bNAv9l/ZSVG+gL0qqIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.a=rsa-sha256 header.s=key header.b=QeHMhT4Z; dkim-atps=neutral; spf=pass (client-ip=136.144.140.114; helo=bout3.ijzerbout.nl; envelope-from=kees@ijzerbout.nl; receiver=lists.ozlabs.org) smtp.mailfrom=ijzerbout.nl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.a=rsa-sha256 header.s=key header.b=QeHMhT4Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ijzerbout.nl (client-ip=136.144.140.114; helo=bout3.ijzerbout.nl; envelope-from=kees@ijzerbout.nl; receiver=lists.ozlabs.org)
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqpbW6k4Qz2ysX
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Nov 2024 07:32:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731702725; bh=aW0kZXCjwMJkAvO9eGrMTuU564xR45DjHMlx+V4e670=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QeHMhT4Zs6fgL1xTGbR5gC4hQqUmKKeyRJFxO6CGGf7WsIf7m4fxhFOcKeoK0KrMa
	 HWuLBlIm2hXivW4vyOHHsZ2R8gfLbGyax+8HF4AMY+G+vp0ly7uX4qMLmxVMNdIfsw
	 GN3/MV1yHiHGsVhiAly54eawmHiD1EC1TV5rvt3zKe3oSvjRgqbiMGzox+AgYKiICK
	 p/pa8VsdyE7qHc4SiqawWHBxzK89GtQsK12xNh+Y3ZriJNsJ/LyH3dI9kHt7bau2uJ
	 VlIJ5dQncKjSE9lG+ShI7oYB7LmpwL1zbScAmtVxtPMd1SQxtKSJ7zUavRnC1kWV+/
	 j0lhNwUHsLyQKY0k8s/okKEBXRAoP2rr0D09L0WvH+hO+0ERvYy/SWvKzYsPFz8VX8
	 s/mKq4LASMQ8xdNuxbwaMkuJ12rn8YpFb1iSSd8giG5FP/5jm5c918mouNSkD2/91Q
	 OcLS182MwxzqpojOVoINTZ5JXbG/tl5qMcKIfPKlvMCAy0myE6EC3Q5FZKzvpXhZyX
	 i8O8Q47umz52anLbdpycCdz7+f5pd4+Egishgq9vRBTJCK4CKl8BX1nIYlVJh1IYCT
	 D6tQyiAKznHrv/y2Bjui8nj+WkPgHsSkEyGN7GNJEtc1Z09bFtiJg0VUioI3mV8Eq8
	 UFg72HmB4pDw9/qKIJBxNRiE=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id D88A216029D;
	Fri, 15 Nov 2024 21:32:04 +0100 (CET)
Message-ID: <17eb79fc-ccd9-4c85-bd23-e08380825c41@ijzerbout.nl>
Date: Fri, 15 Nov 2024 21:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/33] afs: Use netfslib for directories
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Steve French <smfrench@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20241108173236.1382366-1-dhowells@redhat.com>
 <20241108173236.1382366-24-dhowells@redhat.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241108173236.1382366-24-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Shyam Prasad N <sprasad@microsoft.com>, v9fs@lists.linux.dev, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Op 08-11-2024 om 18:32 schreef David Howells:
> In the AFS ecosystem, directories are just a special type of file that is
> downloaded and parsed locally.  Download is done by the same mechanism as
> ordinary files and the data can be cached.  There is one important semantic
> restriction on directories over files: the client must download the entire
> directory in one go because, for example, the server could fabricate the
> contents of the blob on the fly with each download and give a different
> image each time.
>
> So that we can cache the directory download, switch AFS directory support
> over to using the netfslib single-object API, thereby allowing directory
> content to be stored in the local cache.
>
> To make this work, the following changes are made:
>
>   (1) A directory's contents are now stored in a folio_queue chain attached
>       to the afs_vnode (inode) struct rather than its associated pagecache,
>       though multipage folios are still used to hold the data.  The folio
>       queue is discarded when the directory inode is evicted.
>
>       This also helps with the phasing out of ITER_XARRAY.
>
>   (2) Various directory operations are made to use and unuse the cache
>       cookie.
>
>   (3) The content checking, content dumping and content iteration are now
>       performed with a standard iov_iter iterator over the contents of the
>       folio queue.
>
>   (4) Iteration and modification must be done with the vnode's validate_lock
>       held.  In conjunction with (1), this means that the iteration can be
>       done without the need to lock pages or take extra refs on them, unlike
>       when accessing ->i_pages.
>
>   (5) Convert to using netfs_read_single() to read data.
>
>   (6) Provide a ->writepages() to call netfs_writeback_single() to save the
>       data to the cache according to the VM's scheduling whilst holding the
>       validate_lock read-locked as (4).
>
>   (7) Change local directory image editing functions:
>
>       (a) Provide a function to get a specific block by number from the
>       	 folio_queue as we can no longer use the i_pages xarray to locate
>       	 folios by index.  This uses a cursor to remember the current
>       	 position as we need to iterate through the directory contents.
>       	 The block is kmapped before being returned.
>
>       (b) Make the function in (a) extend the directory by an extra folio if
>       	 we run out of space.
>
>       (c) Raise the check of the block free space counter, for those blocks
>       	 that have one, higher in the function to eliminate a call to get a
>       	 block.
>
>       (d) Remove the page unlocking and putting done during the editing
>       	 loops.  This is no longer necessary as the folio_queue holds the
>       	 references and the pages are no longer in the pagecache.
>
>       (e) Mark the inode dirty and pin the cache usage till writeback at the
>       	 end of a successful edit.
>
>   (8) Don't set the large_folios flag on the inode as we do the allocation
>       ourselves rather than the VM doing it automatically.
>
>   (9) Mark the inode as being a single object that isn't uploaded to the
>       server.
>
> (10) Enable caching on directories.
>
> (11) Only set the upload key for writeback for regular files.
>
> Notes:
>
>   (*) We keep the ->release_folio(), ->invalidate_folio() and
>       ->migrate_folio() ops as we set the mapping pointer on the folio.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/afs/dir.c               | 742 +++++++++++++++++++------------------
>   fs/afs/dir_edit.c          | 183 ++++-----
>   fs/afs/file.c              |   8 +
>   fs/afs/inode.c             |  21 +-
>   fs/afs/internal.h          |  16 +
>   fs/afs/super.c             |   2 +
>   fs/afs/write.c             |   4 +-
>   include/trace/events/afs.h |   6 +-
>   8 files changed, 512 insertions(+), 470 deletions(-)
>
> [...]
> +/*
> + * Iterate through the directory folios under RCU conditions.
> + */
> +static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *ctx)
> +{
> +	struct afs_vnode *dvnode = AFS_FS_I(dir);
> +	struct iov_iter iter;
> +	unsigned long long i_size = i_size_read(dir);
> +	int ret = 0;
>   
> -		do {
> -			dblock = kmap_local_folio(folio, offset);
> -			ret = afs_dir_iterate_block(dvnode, ctx, dblock,
> -						    folio_pos(folio) + offset);
> -			kunmap_local(dblock);
> -			if (ret != 1)
> -				goto out;
> +	/* Round the file position up to the next entry boundary */
> +	ctx->pos = round_up(ctx->pos, sizeof(union afs_xdr_dirent));
>   
> -		} while (offset += sizeof(*dblock), offset < size);
> +	if (i_size <= 0 || ctx->pos >= i_size)
> +		return 0;
>   
> -		ret = 0;
> -	}
> +	iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
> +	iov_iter_advance(&iter, round_down(ctx->pos, AFS_DIR_BLOCK_SIZE));
> +
> +	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, ctx,
> +		       afs_dir_iterate_step);
> +
> +	if (ret == -ESTALE)
This is dead code because `ret` is set to 0 and never changed.
> +		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);
> +	return ret;
> +}
> [...]
