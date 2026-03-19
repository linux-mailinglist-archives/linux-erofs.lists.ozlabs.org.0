Return-Path: <linux-erofs+bounces-2848-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLwtNnn2u2kQqwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2848-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:13:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA92CBBD4
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:13:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc5jX69f8z2ynW;
	Fri, 20 Mar 2026 00:13:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773926000;
	cv=none; b=MvLBFlbkKP+dJ/mieJmokBh2WAnHX9hbtXgglAgJLa7MyF/ykLagSK7lyxBz3usxjkUydJ28OFoarVECgMWl2JkgzZw66E7rkp3sBUqgo5zMinMhAaUx6lPfgkfc+wPmI1cATzGIn7JyGb6z496fqSFXpVtskTqYxuvWDv7X607FwF33gI7mdZBR2H0yNuBvT7ACayMeVB00i/hBH7/O23QCeuOPhtaUoxMV7VlTiICA6wXu9SqtCj/JJPHyskRBOfsdQwIzAPXq2azY1ilDNWdgQ5GrzGx/MOcsAj4IPjtYBESwhuVLZlbRIBNCOKEs/t9dtr4lz/lX5Agh0FcBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773926000; c=relaxed/relaxed;
	bh=GD7tBumoolkFpkpS8DdwTJBV8ddAHfyuWxifKgO6To8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QllDQJAb33DpprP23xuPZwZgt9FI0Gw05buydo+t+DDclbmmPeIZQYaToPXiyRCjpyaecNayjl1AFUtBYeXSmz9jxkJJsgkpRz/LTUQMEog2sCe/Lho3LfpexI6Wshhvf+5eus/vNlqj8PTKTye869XMyvbl+Mh+lXkcKebs1DAiXoZd1885n1K9GDGDIOde+whB2lmXlG7XqyNH+iRj05vZ6euirAHj5aUWeBzvfmfxxMK0RpVk57HzGt6QC8QxTBuf4hQgJTOyYaN9wFv+2xaIeQpUcooBwS0Ouq+ap8LZmhyExKCuPWuPuiWYSpllT3bQoOA3K8PuzNt9VFUuwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Yj9N/NGr; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Yj9N/NGr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc5jW2Bwkz2yLG
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 00:13:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C97576011F;
	Thu, 19 Mar 2026 13:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A62C2BC9E;
	Thu, 19 Mar 2026 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773925995;
	bh=o0GtjwXsZyAZFpgX3LDrd2FmLVg91cOKEz6WcZioyn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yj9N/NGrUHSkSxUHPR5wlrEp09cIUI2NlyADHzuDc7+XVF+gabNTkf6nfPh7iW6GH
	 jRVPjk48eMELakt84A7o+pxeAFDaMSFZ7RS5/Fur6R1urrlorR/wcc8pkTWEn1XB+P
	 Wh/o/O/fokKWwpTjEfPivJ2w4BZDTFMpqP3waU4AYpgK4N4reyPaewH/G+rGR4/ULD
	 FRuUkKaTnq9FpwDXFjs7LjQyVRhFT0+CXTLzmBDW35p3h3LdDjDwdD5vIpTrc6YHNG
	 1cd4FYEISN48Aixb42btL9l4YuK7PWV/Gp8AJwbtbV1VVmFsKpi7hjy0e+uI31cyTN
	 gSvEjnjpjIU/w==
Date: Thu, 19 Mar 2026 14:13:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Paul Moore <paul@paul-moore.com>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative
 dentry
Message-ID: <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
References: <20260319124616.1544415-1-amir73il@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <20260319124616.1544415-1-amir73il@gmail.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [3.80 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2848-lists,linux-erofs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:paul@paul-moore.com,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.992];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: BCFA92CBBD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH file.
> Skip setting them for O_PATH file, so that the O_PATH file could be
> opened with a negative dentry.
> 
> This is not something that a user should be able to do, but vfs code,
> such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> before instantiating the dentry.
> 
> Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Christian,
> 
> This patch fixes the syzbot report [1] that the
> backing_file_user_path_file() patch [2] introduces.
> 
> This is not the only possible fix, but it is the cleanest one IMO.
> There is a small risk in introducing a state of an O_PATH file with
> NULL f_inode, but I (and the bots that I asked) did not find any
> obvious risk in this state.
> 
> Note that specifically, the user path inode is accessed via d_inode()
> and not via file_inode(), which makes this safe for file_user_inode()
> callers.
> 
> BTW, I missed this regression with the original patch because I
> only ran the quick overlayfs sanity test.
> 
> Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> test case is covered and that the bug is detected.
> 
> WDYT?
> 
> Thanks,
> Amir.
> 
> [1] https://syzkaller.appspot.com/bug?extid=f34aab278bf5d664e2be
> [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir73il@gmail.com/
> 
>  fs/open.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 91f1139591abe..2004a8c0d9c97 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
>  
>  	path_get(&f->f_path);
>  	f->f_inode = inode;
> -	f->f_mapping = inode->i_mapping;
> -	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
> -	f->f_sb_err = file_sample_sb_err(f);
>  
>  	if (unlikely(f->f_flags & O_PATH)) {
>  		f->f_mode = FMODE_PATH | FMODE_OPENED;
> @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
>  		return 0;
>  	}
>  
> +	f->f_mapping = inode->i_mapping;
> +	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
> +	f->f_sb_err = file_sample_sb_err(f);
> +
>  	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
>  		i_readcount_inc(inode);
>  	} else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {

I think this is really ugly and I'm really unhappy that we should adjust
initialization of generic vfs code for this. My preference is to push
the pain into the backing file stuff. And my ultimate preference is for
this backing file stuff to be removed again for a simple struct path.
We're working around some more fundamental cleanup here imho.

