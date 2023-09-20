Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D57A8864
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 17:30:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cPiRr5Nl;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6KZkGGsM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrMtc09j2z3cDn
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 01:30:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cPiRr5Nl;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6KZkGGsM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=suse.cz (client-ip=2001:67c:2178:6::1c; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrMtS5mCvz3cDV
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 01:30:40 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A37D21F95;
	Wed, 20 Sep 2023 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695223837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z07gJ0ljk8a9zukVNTeRislBXMh7pJ7EEuF8a+v+/FI=;
	b=cPiRr5NlB4Iwub7EwKz86boVSJQJZ3WLxzLaU6G09EfO4FmtVOdy7KUFneBvjrGmUR3ITh
	2SAzepsqhIpBmvq/dM3lwFGS4jeZb1JiYpwLyM/YRSlBcScjreBuxS42wYeBxMo6k0JIzb
	vOOpZeXkJqjpWBWmAFVZOTXkw8HJ8lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695223837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z07gJ0ljk8a9zukVNTeRislBXMh7pJ7EEuF8a+v+/FI=;
	b=6KZkGGsMv2dh1rvGNnyToBfPP9oSwDD0PDv8XeIzbn7pcxdfbwlBblC3C43EGbanxkRyi5
	mASfcKX9dgdX2bCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DEDB132C7;
	Wed, 20 Sep 2023 15:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +bZeAx0QC2WLRwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 15:30:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97616A077D; Wed, 20 Sep 2023 17:30:36 +0200 (CEST)
Date: Wed, 20 Sep 2023 17:30:36 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Message-ID: <20230920153036.pfg5h4aoed6ua6s3@quack3>
References: <20230919110457.7fnmzo4nqsi43yqq@quack3>
 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
 <4511209.uG2h0Jr0uP@nimes>
 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
 <20230920-leerung-krokodil-52ec6cb44707@brauner>
 <20230920101731.ym6pahcvkl57guto@quack3>
 <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
 <20230920-raser-teehaus-029cafd5a6e4@brauner>
 <57C103E1-1AD2-4D86-926C-481BC6BDB191@oracle.com>
 <20230920-keine-eile-c9755b5825db@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920-keine-eile-c9755b5825db@brauner>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Jan Kara <jack@suse.cz>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Amir Goldstein <l@gmail.com>, Eric Van Hensbergen <ericvh@kern
 el.org>, "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, "cluster-devel@redhat.com" <cluster-devel@redhat.com>, "coda@cs.cmu.edu" <coda@cs.cmu.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Xi Ruoyao <xry111@linuxfromscratch.org>, Shyam Prasad N <sprasad@microsoft.com>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>, Kees Cook <keescook@chromium.org>, "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj
 @kernel.org>, Yue Hu <huyue2@coolpad.com>, Al Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, Jeff Layton <jlayton@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlai
 n <mcgrof@kernel.org>, Chuck Lever III <chuck.lever@oracle.com>, "devel@lists.orangefs.org" <devel@lists.orangefs.org>, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bo b Peterson <rpeterso@redhat.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, Bruno Haible <bruno@clisp.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed 20-09-23 16:53:26, Christian Brauner wrote:
> > You could put it behind an EXPERIMENTAL Kconfig option so that the
> > code stays in and can be used by the brave or foolish while it is
> > still being refined.
> 
> Given that the discussion has now fully gone back to the drawing board
> and this is a regression the honest thing to do is to revert the five
> patches that introduce the infrastructure:
> 
> ffb6cf19e063 ("fs: add infrastructure for multigrain timestamps")
> d48c33972916 ("tmpfs: add support for multigrain timestamps")
> e44df2664746 ("xfs: switch to multigrain timestamps")
> 0269b585868e ("ext4: switch to multigrain timestamps")
> 50e9ceef1d4f ("btrfs: convert to multigrain timestamps")
> 
> The conversion to helpers and cleanups are sane and should stay and can
> be used for any solution that gets built on top of it.
> 
> I'd appreciate a look at the branch here:
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.ctime.revert
> 
> survives xfstests.

Agreed. I think most of ffb6cf19e063 ("fs: add infrastructure for
multigrain timestamps") will be needed anyway but there's no problem in
reintroducing it in the new solution. I've checked the branch and the
reverts look good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
