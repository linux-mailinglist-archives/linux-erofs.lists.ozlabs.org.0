Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D52417A7A7A
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 13:32:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R5bCngaw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrGbl07kyz3c2k
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 21:32:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R5bCngaw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrGbb3lmHz3c12
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 21:32:27 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 4A739CE168E;
	Wed, 20 Sep 2023 11:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEEDC433C7;
	Wed, 20 Sep 2023 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695209540;
	bh=w0l124j9VzNbwK8B5nriqS4Qd3S5f3zrUT5Lnscm8ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5bCngawUng+9QtvuxLQnS/+ODBBi9hkhhQQj5tdlYRZsB8VvLu4jvEZz3BMChki5
	 ZPpB//oF8R71JGdjoUQPOvFz+1wDOxMOBzDPshdj9nZBoukNkYc119FVwLUPM5EhKs
	 jUXahXbnZIIxzradMLtT0nNmXRUXvmM+XFkiZ22fjd1HrwtI/boUTBQtPiHn0qhuy6
	 rv+JKlSwUFFKvsmZ89mVo9MCEshxQjFK2QkY1LZEH9LpPwd+yXs3DXKl22Qvx4u5HJ
	 UR76am/suab16CXc3uu8P9yCNJWjB+cisWWdgE5CFnZsUjmCbeLpBiinindwGeFxZM
	 iCBNGk+MZ6H3w==
Date: Wed, 20 Sep 2023 19:32:12 +0800
From: Gao Xiang <xiang@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: mkfs: support tgz streams for tarerofs
Message-ID: <ZQrYPBo7ykgQe/3v@debian>
Mail-Followup-To: Gao Xiang <hsiangkao@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org
References: <20230919185947.3996843-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919185947.3996843-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 20, 2023 at 02:59:47AM +0800, Gao Xiang wrote:
> Introduce iostream to wrap up the input tarball stream for tarerofs.
> 
> Besides, add bultin tgz support if zlib is linked to mkfs.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Apply the following diff to fix pax header regression:

diff --git a/lib/tar.c b/lib/tar.c
index 52036a6..0744972 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -191,7 +191,7 @@ int erofs_iostream_bread(struct erofs_iostream *ios, void *buf, u64 bytes)
 		rem -= ret;
 	} while (rem && ret);
 
-	return rem;
+	return bytes - rem;
 }
 
 int erofs_iostream_lskip(struct erofs_iostream *ios, u64 sz)
