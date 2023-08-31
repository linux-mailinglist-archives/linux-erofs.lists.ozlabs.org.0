Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7278EFD0
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 16:54:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t52TUp9a;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rc4260ssZz3bhk
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 00:54:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t52TUp9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rc41z17Jfz2yhP
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Sep 2023 00:54:31 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFB56231D;
	Thu, 31 Aug 2023 14:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF46C433C8;
	Thu, 31 Aug 2023 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693493666;
	bh=DuXZKdEhLyFnMejmr4ZjLYv/mL/Ja85TZqspW8EaDWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t52TUp9aWDNmi7j4CJazOW+RnI+JUZ4WnMUZx9Mk8tfJvCKbR/E2GyxfM/N84spqa
	 RW1ZmDHXOY0okHIFpw4JJMokbNiYh0Z73/b2NdadQP6fjNLUaT5vJ07nJTNSp/H5mw
	 3E0aLlTdIfBi9dsMG+6MrpsKVQ1d4HgiezRytEBMHsheC0qOe9RNe3x69mzc7XpjH0
	 ccxKueNhFIJE0Wh6bz/wG/182eXbajsYDvNJdCLeSyhn3UHfMp2btSGpZp5WdZOmgg
	 bRYrerJeZZFdHHTy2rocA8k/0UIjklQdfsBICeZ4FcRIQgh8dWZQdGRfGB4p4Hl39R
	 oY2HReqTVu+Uw==
Date: Thu, 31 Aug 2023 22:54:15 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: dump: support dumping xattr filter feature
 bit
Message-ID: <ZPCpl1BPShRPgNM9@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230831103020.120683-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831103020.120683-1-jefflexu@linux.alibaba.com>
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 31, 2023 at 06:30:20PM +0800, Jingbo Xu wrote:
> Add support for dumping xattr filter feature bit.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Folded into the original patch since -dev hasn't been updated.

Thanks,
Gao Xiang
