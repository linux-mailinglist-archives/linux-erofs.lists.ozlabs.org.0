Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F3842F41
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jan 2024 22:58:13 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=f/lTyC7A;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=Jz95UDCB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TPfDg3djXz3bsT
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jan 2024 08:58:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=f/lTyC7A;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=Jz95UDCB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codewreck.org (client-ip=2001:41d0:1:7a93::1; helo=nautica.notk.org; envelope-from=asmadeus@codewreck.org; receiver=lists.ozlabs.org)
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TPfDS28Tfz2ytj
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jan 2024 08:57:57 +1100 (AEDT)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 6C069C01E; Tue, 30 Jan 2024 22:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706651868; bh=3OM4TbWQ6erHco16GZP6eiXbolJmb1FVgvE2iI59oRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/lTyC7AylluE9U/rrb+EqMMb08YeAv56CHHe1zQ15EqWYC2qNjDv9qB8JyKcrcDi
	 qo+Su4xRp1/QH2BIlOO9yb1sQmzrZDBFiJYn22LcRnLm1jWO3hlouD0PgkXU4htvng
	 V7l1OLr86QG6KCKzFLIrWaXrAR79KCo8Etpqnuvwxvi1v2U3X/G02BaOvDgW/Khphr
	 88j5Z5iqSj+/DNp9D0RLw4ZXfMDZbh0/P9qUDcknOvaIPuLk4S+YgxfK7HjqdxrL1r
	 ZUDUsrWqCVK6ONeNFP1mL470dFi7654rmnqSCC8U1IL9GcUlEUOaAVHM+0fIaQlepN
	 Aa6V/YaBN9fGg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 1F1A9C009;
	Tue, 30 Jan 2024 22:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706651867; bh=3OM4TbWQ6erHco16GZP6eiXbolJmb1FVgvE2iI59oRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jz95UDCBaCc7DNbBv88Y6UtPW8uWNycCk6cHz5RjFY/3zlaTuCtTXG9Rt3/uY0uG5
	 5TNOGUBtkKibEUm+xkwQt/w1KbKcI8teuo9q4z4hcv1gQpDXQu3sPlKtdi4t9NBtrH
	 8hWZlXkK6p3tF+iLckxAh3vygIMPNOTVSuPOqudJjBmw6OiMkqHk5OCcl2WcxvHU/E
	 +GS0FLMkD8Z+632TihN4Q/JR2fW2x351vGu4dw7Hc7cTA4cBIFIXw61BAOcHBYYp8Y
	 U1yfe1icLInyDTUSSeQ9f+RBg8KbXPYx62fbcRiQ1mEjyt+wrKr6hYWqFX34wlPxGo
	 EPGrBHtPIhA8Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c6e1a942;
	Tue, 30 Jan 2024 21:57:38 +0000 (UTC)
Date: Wed, 31 Jan 2024 06:57:23 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/2] netfs: Fix missing zero-length check in unbuffered
 write
Message-ID: <Zblww5O_bRvKx36g@codewreck.org>
References: <20240129094924.1221977-1-dhowells@redhat.com>
 <20240129094924.1221977-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129094924.1221977-3-dhowells@redhat.com>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux_oss@crudebyte.com, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells wrote on Mon, Jan 29, 2024 at 09:49:19AM +0000:
> Fix netfs_unbuffered_write_iter() to return immediately if
> generic_write_checks() returns 0, indicating there's nothing to write.
> Note that netfs_file_write_iter() already does this.
> 
> Also, whilst we're at it, put in checks for the size being zero before we
> even take the locks.  Note that generic_write_checks() can still reduce the
> size to zero, so we still need that check.
> 
> Without this, a warning similar to the following is logged to dmesg:
> 
> 	netfs: Zero-sized write [R=1b6da]
> 
> and the syscall fails with EIO, e.g.:
> 
> 	/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> 
> This can be reproduced on 9p by:
> 
> 	xfs_io -f -c 'pwrite 0 0' /xfstest.test/foo
> 
> Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> Reported-by: Eric Van Hensbergen <ericvh@kernel.org>
> Link: https://lore.kernel.org/r/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Dominique Martinet <asmadeus@codewreck.org>

Thanks!

Tested-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus
