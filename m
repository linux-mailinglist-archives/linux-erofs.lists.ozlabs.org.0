Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D577539C
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 09:08:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XBXM6YuN;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLLkW56R9z306p
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 17:08:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XBXM6YuN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLLkT0NsVz2yVp
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Aug 2023 17:08:33 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4397D60AD5;
	Wed,  9 Aug 2023 07:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB972C433C8;
	Wed,  9 Aug 2023 07:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691564910;
	bh=/rZSqjAZtsBizYYtIOB21nSsnZRBJybWyyf062l+VJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBXM6YuN/DJfcAIiFmHbtES3QfTM1C8dTZvNbHpT0ojlG4HZRC1KRdUNiYIozuLtf
	 Mj8KiYlNBlPNH6bVN/SdgMEWVqW0bd0EXRksBsHLCfEXTYWFcUxKPmMlZQa4BLXc+u
	 HVWJiPLV6I93Alqf8bHPAj4p352DMAD62OU7S075NpSOa7OY8Rzy7Lkh+DmR2NEoSD
	 3F9BROSdL1LVyjHyT/qVqpX14CEeISxG8JvWDSf6VlsP5oBPdi9SjzN2dJtXprrLw2
	 PAttEXxJZrNwNwPks/SfSAHbRPRAuqTa/QqJFHQ6a/wwq8PwFX8puWJ6ZzYsWf6rHi
	 p6EZ4DAxuERvA==
Date: Wed, 9 Aug 2023 09:08:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
Message-ID: <20230809-goldpreis-nennen-798a895973be@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
 <20230808093226.bq2qfxv5npckk643@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808093226.bq2qfxv5npckk643@quack3>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, samba-technical@lists.samba.org, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin 
 Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@lin
 uxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 08, 2023 at 11:32:26AM +0200, Jan Kara wrote:
> On Mon 07-08-23 15:38:36, Jeff Layton wrote:
> > In later patches, we're going to drop the "now" parameter from the
> > update_time operation. Fix fat_update_time to fetch its own timestamp.
> > It turns out that this is easily done by just passing a NULL timestamp
> > pointer to fat_update_time.
>              ^^^ fat_truncate_time()

Fixed in-tree, thanks!
