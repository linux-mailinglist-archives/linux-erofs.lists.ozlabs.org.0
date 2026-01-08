Return-Path: <linux-erofs+bounces-1747-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE41AD04F1E
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:27:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBgD26HLz2xGY;
	Fri, 09 Jan 2026 04:27:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767893256;
	cv=none; b=IlWYjIBm276rSSzi1sDiI3KUEMhpH/3OojrzV9o1DtkFuKuG430e5vEKkwdlRdA3te+V7wQZySVYyzTItFY+wAjXK1KyU6qNVmAigg6rDjlXAX+oizQTDFHnS00CyhruD9RFrKmUXIq8lCRqFelQiE9VWkjTk+jOCXT9ezm6Sd3mly92tBRGIaWv4ZvnMPOsnryzlsU8bysZtXg59cOlGMOFi0tkcdSiHviuCFgEeAiCUXQXHiQpAmMRY8tsdFITx4Qi3WECnFri4RlajEiil2pbpWW2uohZnsayVgzmHkOrcZNfmQxDK/iq7kYlTPFtEYJ/J4NgaF12InvbmB6CBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767893256; c=relaxed/relaxed;
	bh=R7QyMjWNwrqj8UEPWI/WaBPmYmyTfSFG6zvi/rjbSso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsVIXwATmzeOBFsg6T40RBeBUQlO+EONu+fsvZ9ndQrP3ffH9XCNoueOToF0VNzkTRJjw7xoWM2PdUzN6IpxkdFua4yvo0vSfL3JK0CMJy75vOorhFqtUOC+g5EMZuHLZtaPx1Sptj3hJq6MizIv+Gy4ZNxjudYMwLbprKa9Kt6ntAE7V7ld1fUpfNKR+PbfBpUOAJ6qpIEGwwY6DbiVEuWZwbFC9iqhvzK6lD+JVxoEjWMX24e8OJpmgLPBXbLF2ipBsxWP2WtbOYEGNt1qWnBYQKhjlc+NRyUtl6rM8CwkGyuVqH5AZ+LsUt7Wvvi+pCsTXWSrYpQsSlJxqcEo3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zlnIZXTf; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=phfwz5+a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zlnIZXTf; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=phfwz5+a; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zlnIZXTf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=phfwz5+a;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zlnIZXTf;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=phfwz5+a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBgB56ntz2xGF
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:27:33 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 62A895CB7C;
	Thu,  8 Jan 2026 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7QyMjWNwrqj8UEPWI/WaBPmYmyTfSFG6zvi/rjbSso=;
	b=zlnIZXTfinrf7hq5vt4U5cUKJ6NPNUMQKK2r+Tmfi2xEzptt6ClI4wMDQQvjt9dx8n8JRa
	f+6MG01/Jc9w6M+FLcxwyZZdeIID2KjyJifSH8p7z53HnRVuZYr8SQKyqt/r4Pp8Z+ZZ9O
	oGRfCrFhM3vTR5EXInWctDXLZPrEeFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7QyMjWNwrqj8UEPWI/WaBPmYmyTfSFG6zvi/rjbSso=;
	b=phfwz5+a+RuRX25uv+FH1xiHN8WR/XirFu4FyQP6WWGFdXXorQlDWQOreoBzrsu9F8q7u1
	Qxxocyjselc1ZHBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zlnIZXTf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=phfwz5+a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7QyMjWNwrqj8UEPWI/WaBPmYmyTfSFG6zvi/rjbSso=;
	b=zlnIZXTfinrf7hq5vt4U5cUKJ6NPNUMQKK2r+Tmfi2xEzptt6ClI4wMDQQvjt9dx8n8JRa
	f+6MG01/Jc9w6M+FLcxwyZZdeIID2KjyJifSH8p7z53HnRVuZYr8SQKyqt/r4Pp8Z+ZZ9O
	oGRfCrFhM3vTR5EXInWctDXLZPrEeFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7QyMjWNwrqj8UEPWI/WaBPmYmyTfSFG6zvi/rjbSso=;
	b=phfwz5+a+RuRX25uv+FH1xiHN8WR/XirFu4FyQP6WWGFdXXorQlDWQOreoBzrsu9F8q7u1
	Qxxocyjselc1ZHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4627D3EA65;
	Thu,  8 Jan 2026 17:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E6zLEOPoX2kEdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 17:26:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BEB9EA0B23; Thu,  8 Jan 2026 18:26:58 +0100 (CET)
Date: Thu, 8 Jan 2026 18:26:58 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev, 
	linux-doc@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: [PATCH 01/24] fs: add setlease to generic_ro_fops and read-only
 filesystem directory operations
Message-ID: <iik7pdymlt6glogh6f62ps764go4233ub7mgvdctwktc4iszyz@h33w3q63jjrj>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-1-ea4dec9b67fa@kernel.org>
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
In-Reply-To: <20260108-setlease-6-20-v1-1-ea4dec9b67fa@kernel.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,vger.kernel.org,lists.ozlabs.org,lists.sourceforge.net,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org,lists.samba.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLjxstjou9w9fpr873xxxyrjcd)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 62A895CB7C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu 08-01-26 12:12:56, Jeff Layton wrote:
> Add the setlease file_operation to generic_ro_fops, which covers file
> operations for several read-only filesystems (BEFS, EFS, ISOFS, QNX4,
> QNX6, CRAMFS, FREEVXFS). Also add setlease to the directory
> file_operations for these filesystems.	A future patch will change the
> default behavior to reject lease attempts with -EINVAL when there is no
> setlease file operation defined. Add generic_setlease to retain the
> ability to set leases on these filesystems.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/befs/linuxvfs.c        | 2 ++
>  fs/cramfs/inode.c         | 2 ++
>  fs/efs/dir.c              | 2 ++
>  fs/freevxfs/vxfs_lookup.c | 2 ++
>  fs/isofs/dir.c            | 2 ++
>  fs/qnx4/dir.c             | 2 ++
>  fs/qnx6/dir.c             | 2 ++
>  fs/read_write.c           | 2 ++
>  8 files changed, 16 insertions(+)
> 
> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
> index 9fcfdd6b8189aaf5cc3b68aa8dff4798af5bdcbc..d7c5d9270387bf6c3e94942e6331b449f90fe428 100644
> --- a/fs/befs/linuxvfs.c
> +++ b/fs/befs/linuxvfs.c
> @@ -14,6 +14,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  #include <linux/errno.h>
> +#include <linux/filelock.h>
>  #include <linux/stat.h>
>  #include <linux/nls.h>
>  #include <linux/buffer_head.h>
> @@ -79,6 +80,7 @@ static const struct file_operations befs_dir_operations = {
>  	.read		= generic_read_dir,
>  	.iterate_shared	= befs_readdir,
>  	.llseek		= generic_file_llseek,
> +	.setlease	= generic_setlease,
>  };
>  
>  static const struct inode_operations befs_dir_inode_operations = {
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index e54ebe402df79d43a2c7cf491d669829f7ef81b7..41b1a869cf135d014003d6bf1c343d590ae7a084 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/fs.h>
>  #include <linux/file.h>
> +#include <linux/filelock.h>
>  #include <linux/pagemap.h>
>  #include <linux/ramfs.h>
>  #include <linux/init.h>
> @@ -938,6 +939,7 @@ static const struct file_operations cramfs_directory_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= cramfs_readdir,
> +	.setlease	= generic_setlease,
>  };
>  
>  static const struct inode_operations cramfs_dir_inode_operations = {
> diff --git a/fs/efs/dir.c b/fs/efs/dir.c
> index f892ac7c2a35e0094a314eeded06a974154e46d7..35ad0092c11547af68ef8baf4965b50a0a7593fe 100644
> --- a/fs/efs/dir.c
> +++ b/fs/efs/dir.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/buffer_head.h>
> +#include <linux/filelock.h>
>  #include "efs.h"
>  
>  static int efs_readdir(struct file *, struct dir_context *);
> @@ -14,6 +15,7 @@ const struct file_operations efs_dir_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= efs_readdir,
> +	.setlease	= generic_setlease,
>  };
>  
>  const struct inode_operations efs_dir_inode_operations = {
> diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
> index 1b0bca8b4cc686043d92246042dcf833d37712e4..138e08de976ea762a46043316f27e9a031f60c32 100644
> --- a/fs/freevxfs/vxfs_lookup.c
> +++ b/fs/freevxfs/vxfs_lookup.c
> @@ -8,6 +8,7 @@
>   * Veritas filesystem driver - lookup and other directory related code.
>   */
>  #include <linux/fs.h>
> +#include <linux/filelock.h>
>  #include <linux/time.h>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
> @@ -36,6 +37,7 @@ const struct file_operations vxfs_dir_operations = {
>  	.llseek =		generic_file_llseek,
>  	.read =			generic_read_dir,
>  	.iterate_shared =	vxfs_readdir,
> +	.setlease =		generic_setlease,
>  };
>  
>  
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index 09df40b612fbf27a1a93af2b4fbf6a607f4a1ab4..2ca16c3fe5ef3427e5bbd0631eb8323ef3c58bf1 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -12,6 +12,7 @@
>   *  isofs directory handling functions
>   */
>  #include <linux/gfp.h>
> +#include <linux/filelock.h>
>  #include "isofs.h"
>  
>  int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
> @@ -271,6 +272,7 @@ const struct file_operations isofs_dir_operations =
>  	.llseek = generic_file_llseek,
>  	.read = generic_read_dir,
>  	.iterate_shared = isofs_readdir,
> +	.setlease = generic_setlease,
>  };
>  
>  /*
> diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
> index 42a529e26bd68b6de1a7738c409d5942a92066f8..6402715ab377e5686558371dd76e5a4c1cfbb787 100644
> --- a/fs/qnx4/dir.c
> +++ b/fs/qnx4/dir.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/buffer_head.h>
> +#include <linux/filelock.h>
>  #include "qnx4.h"
>  
>  static int qnx4_readdir(struct file *file, struct dir_context *ctx)
> @@ -71,6 +72,7 @@ const struct file_operations qnx4_dir_operations =
>  	.read		= generic_read_dir,
>  	.iterate_shared	= qnx4_readdir,
>  	.fsync		= generic_file_fsync,
> +	.setlease	= generic_setlease,
>  };
>  
>  const struct inode_operations qnx4_dir_inode_operations =
> diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
> index b4d10e45f2e41b45568fe813a3cc0aa253bcab6e..ae0c9846833d916beb7f356cfa6e9de01a6f6963 100644
> --- a/fs/qnx6/dir.c
> +++ b/fs/qnx6/dir.c
> @@ -11,6 +11,7 @@
>   *
>   */
>  
> +#include <linux/filelock.h>
>  #include "qnx6.h"
>  
>  static unsigned qnx6_lfile_checksum(char *name, unsigned size)
> @@ -275,6 +276,7 @@ const struct file_operations qnx6_dir_operations = {
>  	.read		= generic_read_dir,
>  	.iterate_shared	= qnx6_readdir,
>  	.fsync		= generic_file_fsync,
> +	.setlease	= generic_setlease,
>  };
>  
>  const struct inode_operations qnx6_dir_inode_operations = {
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 833bae068770a4e410e4895132586313a9687fa2..50bff7edc91f36fe5ee24198bd51a33c278d40a2 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -20,6 +20,7 @@
>  #include <linux/compat.h>
>  #include <linux/mount.h>
>  #include <linux/fs.h>
> +#include <linux/filelock.h>
>  #include "internal.h"
>  
>  #include <linux/uaccess.h>
> @@ -30,6 +31,7 @@ const struct file_operations generic_ro_fops = {
>  	.read_iter	= generic_file_read_iter,
>  	.mmap_prepare	= generic_file_readonly_mmap_prepare,
>  	.splice_read	= filemap_splice_read,
> +	.setlease	= generic_setlease,
>  };
>  
>  EXPORT_SYMBOL(generic_ro_fops);
> 
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

