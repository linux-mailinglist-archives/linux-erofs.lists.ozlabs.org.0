Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DB582523B
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Jan 2024 11:38:35 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a0U9IsNP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T60L12fpbz3cc5
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Jan 2024 21:38:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a0U9IsNP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T60Dy0Tw4z3cVJ
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Jan 2024 21:34:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DF30561877;
	Fri,  5 Jan 2024 10:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FFAC433C8;
	Fri,  5 Jan 2024 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704450846;
	bh=EsAKavy0GWz3zQK8s9XKK/HXklGdoTstOd7k03h30lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0U9IsNPozZgYWWC8Y3pbxdtD0bUsBDufoSawIQnDL4EB5ojEjF8Jth3vzIS13Ugc
	 8oDY8Ljk/3UxhiGPHI4WgL28Kq9jwbpzPbHwFXm4b46X8qrKc7emGM8HHEBcWG4/Bo
	 +RnrQJiWywula2Z1OaxnuocVUH/UEExziaBKPociI2OLHYUz0s+4nRRIn/L0e2Ywhs
	 LInWrA0njjtH1PnP5nAU8yaKSPpufnb5xjukJ8xApXi7v5fCErk+w3EQxsQlRnz24K
	 I3eIzBsYCbep9plLJghK6w6UOMSuRxr9SfQtKGughxU3wcO2fpVXi2MLdjjbfJWYfe
	 mfVRRk6+CS6Pw==
Date: Fri, 5 Jan 2024 11:33:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/5] netfs, cachefiles, 9p: Additional patches
Message-ID: <20240105-packen-inspektion-71fac65bf899@brauner>
References: <20240103145935.384404-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 03, 2024 at 02:59:24PM +0000, David Howells wrote:
> Hi Christian, Jeff, Gao, Dominique,
> 
> Here are some additional patches for my netfs-lib tree:
> 
>  (1) Fix __cachefiles_prepare_write() to correctly validate against the DIO
>      alignment.
> 
>  (2) 9p: Fix initialisation of the netfs_inode so that i_size is set before
>      netfs_inode_init() is called.
> 
>  (3) 9p: Do a couple of cleanups (remove a couple of unused vars and turn a
>      BUG_ON() into a warning).
> 
>  (4) 9p: Always update remote_i_size, even if we're asked not to update
>      i_size in stat2inode.
> 
>  (5) 9p: Return the amount written in preference to an error if we wrote
>      something.
> 
> David
> 
> The netfslib postings:
> Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.com/ # v1
> Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.com/ # v2
> Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.com/ # v3
> Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.com/ # v4
> Link: https://lore.kernel.org/r/20231221132400.1601991-1-dhowells@redhat.com/ # v5

Pulled this into vfs.netfs. Thanks, David.
