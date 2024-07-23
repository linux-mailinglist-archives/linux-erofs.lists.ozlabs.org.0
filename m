Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A383693A8D1
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 23:47:27 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MvVDBFWx;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EnqrR8br;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MvVDBFWx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EnqrR8br;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WT9jT43L1z3cj7
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 07:47:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MvVDBFWx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EnqrR8br;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MvVDBFWx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EnqrR8br;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
X-Greylist: delayed 39700 seconds by postgrey-1.37 at boromir; Wed, 24 Jul 2024 07:47:18 AEST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WT9jL1Htnz3cK8
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2024 07:47:17 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8753C21AF9;
	Tue, 23 Jul 2024 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721771233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpHcZwTJx2XsG9I5Zbrs4QADhHKv8JRyCztbBfSL5dU=;
	b=MvVDBFWx8TP0Aw1w7Plsn7VZRZjB6ToX2pWntC9kYuOAG2+AgHA7RczvZZAC8pwlNNfxcd
	MrNjUG5KmgxsymPs9ioBUFsaZyIabYqSVot/4ozkvBK+Q3Wj0pgXfIF/dJFjcqQZEavjxn
	aga8dD5qgnUaoG31DDfWYmqQePcQgow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721771233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpHcZwTJx2XsG9I5Zbrs4QADhHKv8JRyCztbBfSL5dU=;
	b=EnqrR8br+BjFqzxIiJJKZcDrdDbacIFPywX/la6d3y1+PSx70T6x5PfnbNVPd4ZD7r4fdY
	AZxAQA5owXe4hUDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MvVDBFWx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EnqrR8br
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721771233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpHcZwTJx2XsG9I5Zbrs4QADhHKv8JRyCztbBfSL5dU=;
	b=MvVDBFWx8TP0Aw1w7Plsn7VZRZjB6ToX2pWntC9kYuOAG2+AgHA7RczvZZAC8pwlNNfxcd
	MrNjUG5KmgxsymPs9ioBUFsaZyIabYqSVot/4ozkvBK+Q3Wj0pgXfIF/dJFjcqQZEavjxn
	aga8dD5qgnUaoG31DDfWYmqQePcQgow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721771233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpHcZwTJx2XsG9I5Zbrs4QADhHKv8JRyCztbBfSL5dU=;
	b=EnqrR8br+BjFqzxIiJJKZcDrdDbacIFPywX/la6d3y1+PSx70T6x5PfnbNVPd4ZD7r4fdY
	AZxAQA5owXe4hUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F0131377F;
	Tue, 23 Jul 2024 21:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eo2tGuEkoGY+QAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jul 2024 21:47:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A56B7A08C6; Tue, 23 Jul 2024 14:57:10 +0200 (CEST)
Date: Tue, 23 Jul 2024 14:57:10 +0200
From: Jan Kara <jack@suse.cz>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240723125710.mtnfaycuvdi4dpdy@quack3>
References: <2136178.1721725194@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2136178.1721725194@warthog.procyon.org.uk>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8753C21AF9
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Regarding the contents of the change itself:

On Tue 23-07-24 09:59:54, David Howells wrote:
> @@ -954,15 +952,23 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
>  SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
>  {
>  	struct fd f = fdget(fd);
> +	char kname[XATTR_NAME_MAX + 1];
>  	int error = -EBADF;
>  
>  	if (!f.file)
>  		return error;
>  	audit_file(f.file);
> +
> +	error = strncpy_from_user(kname, name, sizeof(kname));
> +	if (error == 0 || error == sizeof(kname))
> +		error = -ERANGE;
> +	if (error < 0)
> +		return error;

Missing fdput() here.

> +
>  	error = mnt_want_write_file(f.file);
>  	if (!error) {
>  		error = removexattr(file_mnt_idmap(f.file),
> -				    f.file->f_path.dentry, name);
> +				    f.file->f_path.dentry, kname);
>  		mnt_drop_write_file(f.file);
>  	}
>  	fdput(f);

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
