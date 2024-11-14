Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D09C8F83
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 17:18:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xq51R2v5Sz30P0
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 03:18:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731601113;
	cv=none; b=Fd4969kcRYN6mqQfib0wMAC/URztc3Zr2SZ1BNrHhSQ9+mYg4tV1DWl5TuLtNjsheHJZhbzgoRziXLxGGTz/rVSAtOhkU/AWFkwOfadwx6bqPF3IzjhUQ9nXMMxquIuJgKfaM9UPMSC0+/FD5wXie71xnCh8cAcN/nJFx4NHgo5I+rS5lbebrtkl3JUiUDd1c1pUvCqY0QevFWr9rJOThNZHDVJeDC8oLTva249L7lSj0CT4H9HO1PiyHQA2txwZHTpVG/B4FxeTZd/7rRJWc9yylpbpiJF65IF+1b3aTZp+nE2a6AF5vUMfI/VnrwJPKtUgghFsS+pGkAgLFtuohg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731601113; c=relaxed/relaxed;
	bh=60CpvTS8y28+G06qyIsEsZ2zgscU9EQI3R4bXZJMd3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLtPYP8PO8ejWuj63AMceOgO5eBsHwvkDlETFY0LuBWPMGzxhSlMrl0Y1MDjzuLAw3WKuV+IaX5OpNMJatTivRaKMqOaC+tmdjZLcoOLEGB4l7C++CATf2YNLgxSro4mBK71H65X7l+xiVfu4pjlk8W30nA9xAKtHxsRPzxeOEguDlkgM9rHH04itIdSc+2N/wS60RA4vbKNarHdWsk+Co1oFnMBlTqYhGoJSvVedTqE6RFTEVVGIUXIJN0bzAEGoGyUKIhPli4pLT7Px0jOyinDZLcAxDQKqgGoMI6brrzfFCJUShTkikPUwaOqif9v7Eh6j5VYawfbJFugudoJfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=ng2HbV9o; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=ng2HbV9o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xq51N2Sjyz2ysh
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 03:18:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=60CpvTS8y28+G06qyIsEsZ2zgscU9EQI3R4bXZJMd3E=; b=ng2HbV9oGrlnpiOiJSupabDi5/
	qyvBEzqieb2GvNdM6bQfELzVedcCFzxu+e+4TjR7gBMTsyy8zrQouFSxnhmmWOgcVnmqCvzkAaKbW
	9YcRE5TP6m3D/O2Q5IJf9APa/t8ng5NfYVocKgRm0b9JZnP9uzi6MUlqur64tH3SytDkRbhK6CFkZ
	fP+N/zdnpHdGaaM48K4sal05CLu+fGxxhtZW/4jdKGanzziKYApxs1frumXPj/rzRJEeGfUV12soh
	A2miRyUy8wQW0GLm4sBqnGUuaLR7gxFy0YdWMl1ac/ihwCLIVlGHmaMUwqiAET+GhwP00kRoXWLOk
	UkcJcTVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcY4-0000000Eyhp-03AE;
	Thu, 14 Nov 2024 16:18:24 +0000
Date: Thu, 14 Nov 2024 16:18:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix file-backed mounts over FUSE
Message-ID: <20241114161823.GN3387508@ZenIV>
References: <20241114090109.757690-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114090109.757690-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.0
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 14, 2024 at 05:01:09PM +0800, Gao Xiang wrote:
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -38,7 +38,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
>  	}
>  	if (!folio || !folio_contains(folio, index)) {
>  		erofs_put_metabuf(buf);
> -		folio = read_mapping_folio(buf->mapping, index, NULL);
> +		folio = buf->file ? read_mapping_folio(buf->file->f_mapping,
> +					index, buf->file) :
> +			read_mapping_folio(buf->mapping, index, NULL);
>  		if (IS_ERR(folio))
>  			return folio;
>  	}
> @@ -61,8 +63,8 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if (erofs_is_fileio_mode(sbi))
> -		buf->mapping = file_inode(sbi->fdev)->i_mapping;
> +	if (erofs_is_fileio_mode(sbi))	/* some fs like FUSE needs it */
> +		buf->file = sbi->fdev;

Would be easier to set *both* ->mapping and ->file at that point, so that
erofs_bread() would just have read_mapping_folio(buf->mapping, index, buf->file),
unconditionally...
