Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 080BD969177
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 04:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725331087;
	bh=TRVL9ISUj2NM95nVZR93PyDfyOfsECfnzztpvLyuYT0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NYKc/RQ87g6oiA6o+EveuLcOE41Oq5nLZaC29tqKXq0PjWxVu1XqkOE64P1d9hs6/
	 CqQ/GMKJgdqJ1jK2KJQtAj5kTD/PZwz6c9hf6qaXORsgHTzvFeDEar4NSvvNx2ZeNY
	 PF8o/99Smb7eiPHe6tmhR2SWwP4wGSIds2Xz8xnMwmFO2AmT9nHkBjk1fTuExO6lMV
	 6b2OHN3f+qnHwsfFVf7hIKMHteAzrOAm4nH+H+1PkMTp0+Xi8MPX41HzLr3S1aHYDS
	 3dWsLHxEg50eg8/otQdyebExx/HpIJHvgxElU1ZDiaSfGk0hhU5nwK3pd4//mfJ60G
	 PUv6j9hevI6mg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WyVCz6vwFz2yNJ
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 12:38:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725331085;
	cv=none; b=iaLCJkNKLWg2pPAQum5lIKBvJe/cRGGGgMQZLvcWJkisM4KK9kjVwS31QOElaODvlbj8BZwqMtjBZUEg8r8KUq/f60vZs824o+lKbvWrJ2x+5BHcCpkiFZrTc1BBIaVJD6qUCOwpDt+pUv6BWiITSC5AN+Dh/gOU7W5zehZKvwZsuWRF/Ie2i7cFBTAgcnIzEpOx6O/KoGcPE/iWDZ0iPz55TiNYuPkPf7zV5Beo4RwpJExJNtCaSS+hiqjxQvVnXkx99ZjkGpFBcbuQl6wl/zsPIStdCikjMT/ZE7pp4WxsxD1Omabmb2VJk26LFibGAeYRZC/V7mkqB8Vy5h5KNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725331085; c=relaxed/relaxed;
	bh=TRVL9ISUj2NM95nVZR93PyDfyOfsECfnzztpvLyuYT0=;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=D9jIwydpQ1IS9IHmG5UHmQ5/iQQnIG1ZV0BroD+vYfpl9INpq9C/LX1zXzgSyNL/xNnqWq5dY0BRb7C81Jz0D1+MYmER6XD0EgE1Wyp/ujWz/bpBDnanmc5vOU5k0/Hb0Ws3ECuhXP4fB9HVWXZ7txct3QrfWGc2nszOLLc/FStC5BJUyA+GDFaSiWY6qMzcyeqYpTDIjc3quNYZiFh76y67dHqqnyZIsiELfE0p6u8mMZNVzvYfHCfIAUjwpPcdnSWSFmfI3gWMts54JpGPOl6LenAf8kmfp+ImzjMyuM+9Cdy1pLiDCWQ+2EYMNz6+IR9lUz85yRN4kxW9Le5yTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gi4c1GtO; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gi4c1GtO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WyVCx39cKz2yJL
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2024 12:38:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 14F57A409BB;
	Tue,  3 Sep 2024 02:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38B3C4CEC2;
	Tue,  3 Sep 2024 02:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725331081;
	bh=s3ixy1Dk0VBO3qFac0eQGqV2MWZpl1pz4srEs/WX2P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gi4c1GtOn5/HucTPGizj/UeHFF4sYHJTsoq8PWHPFGJ+qE23qcXYa+aY2bar1EJT/
	 2PcZNxXAvF/zjkv6bUF2tUOVZuAqMCBgC76FT+yLy6aJt2yk4ZNoUO18cwlH2zbTeS
	 ZWZmWgcKWgigzCfk3XSC8QsTLgW4z+5PKfX8GZ9OSX9A6761P6YZzTcbqpdWwsYB+Y
	 Mec+IAau14Q293Ssgo+V4yLpXFt4P7AYs/VWXz2sTTrMp+5fA6cxX/RO+kL9DN5oD4
	 zArRKo/bUzWmuqA/0egxtQJqpjbIxq11LUNPTcPCWvPerfi0i5OWl++R72tG78XHxr
	 WDyPKby28kDYw==
Date: Tue, 3 Sep 2024 10:37:55 +0800
To: Yiyang Wu <toolmanp@tlmp.cc>
Subject: Re: [PATCH V4 2/2] erofs: refactor read_inode calling convention
Message-ID: <ZtZ2gygmwGSAuPgS@debian>
Mail-Followup-To: Yiyang Wu <toolmanp@tlmp.cc>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
 <20240902093412.509083-1-toolmanp@tlmp.cc>
 <94737216-af40-44b0-ab3e-e5bfdbffab5f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94737216-af40-44b0-ab3e-e5bfdbffab5f@linux.alibaba.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2024 at 05:54:22PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/9/2 17:34, Yiyang Wu wrote:
> > Refactor out the iop binding behavior out of the erofs_fill_symlink
> > and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
> > can only deal with inode operation bindings and can be decoupled from
> > metabuf operations. This results in better calling conventions.
> > 
> > Note that after this patch, we do not need erofs_buf and ofs as
> > parameters any more when calling erofs_read_inode as
> > all the data operations are now included in itself.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
> > Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang

Applied with the following minor cleanups:

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 726a93a0413c..31d811b50291 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -16,9 +16,8 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
+	    inode->i_size >= bsz || inode->i_size < 0)
 		return 0;
-	}
 
 	m_pofs += vi->xattr_isize;
 	/* inline symlink data shouldn't cross block boundary */
@@ -204,7 +203,7 @@ static int erofs_read_inode(struct inode *inode)
 static int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	int err = 0;
+	int err;
 
 	trace_erofs_fill_inode(inode);
 

