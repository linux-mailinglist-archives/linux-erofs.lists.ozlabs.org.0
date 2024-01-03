Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184058235C9
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 20:46:17 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=wnu79S7k;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=B4k+m/q8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T50Zs00zvz3bsX
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 06:46:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=wnu79S7k;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=B4k+m/q8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codewreck.org (client-ip=91.121.71.147; helo=nautica.notk.org; envelope-from=asmadeus@codewreck.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 173 seconds by postgrey-1.37 at boromir; Thu, 04 Jan 2024 06:46:04 AEDT
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T50Zh1d6lz3bhc
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 06:46:04 +1100 (AEDT)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 01C48C026; Wed,  3 Jan 2024 20:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704311162; bh=DYpAMKUEr4ZUo/A2V1G5Stqgcj7W2gBmNsNpjPAItNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wnu79S7kdE+HWljFIVMAS7Vk67BpQzcH/o34qldo/6irXMtO+faoEAyINGHxImOXX
	 9GP17leT7P1W463WpEJZkyiolgk52RwUBvSDdgQYZSlPA93YktS1I4MZNigEYvKvBC
	 Xk0YC9QAjdB9I5r1MXBi2OE/AsG90K1YZh/emHkgct2U+wc2yremZ4RwFLOcwAMujr
	 9sigwMmkv11kEXwB4THRJaP3J0I1fvAwnwFDvawq+X2g060DS0uESZGmYMxXT0JtuE
	 V3hB2WyD18x19osmXaW0egTf7IMBbX/p0vKGtZImTCyeKKt18MSd4XpeBgjHEcsMVL
	 NAdWTSCvrXIHw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 13998C01A;
	Wed,  3 Jan 2024 20:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704311161; bh=DYpAMKUEr4ZUo/A2V1G5Stqgcj7W2gBmNsNpjPAItNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4k+m/q8vwyz1cmJjWarRzlV3PUa/4GYuScLc3MH9IP8RXLMxQgNKo26pq046ww1w
	 IXiwt0dLInSvuNJJhA69DW/3p05amxvZHcQYMeEGw4S0aXDDnM+hfwt6n23bW8rE0j
	 321wZwAkYtQ2G2n2+mY3DL2D4JIsNe02StYEJsq7JutX4onPpj3vRyZbc1iQzVvJau
	 BhSK0FEsTlhA3v6B2bG4rvREluC3TF7JpZvOXy8473obAqXXGRVKv9zNB9Ekw5yCRB
	 P1E0WP0KYgz5HWK4aIG7D+g2rhNpqeTEVLUtzx/r4CDXibmlMLGrVTN1XCxXzGJmdX
	 SKwuMgP0lMVHw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 7038adea;
	Wed, 3 Jan 2024 19:45:51 +0000 (UTC)
Date: Thu, 4 Jan 2024 04:45:36 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/5] 9p: Do a couple of cleanups
Message-ID: <ZZW5YEy0xiGp1JRT@codewreck.org>
References: <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-4-dhowells@redhat.com>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells wrote on Wed, Jan 03, 2024 at 02:59:27PM +0000:
> Do a couple of cleanups to 9p:
> 
>  (1) Remove a couple of unused variables.
> 
>  (2) Turn a BUG_ON() into a warning, consolidate with another warning and
>      make the warning message include the inode number rather than
>      whatever's in i_private (which will get hashed anyway).
> 
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>

Thanks,

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus
