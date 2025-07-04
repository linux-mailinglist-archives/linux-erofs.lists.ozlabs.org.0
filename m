Return-Path: <linux-erofs+bounces-520-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3ABAF9185
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 13:25:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYWXJ71N9z3brB;
	Fri,  4 Jul 2025 21:25:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751628336;
	cv=none; b=Mq1+H85STMK6y2caHwi7e5wv5qKRrKgHuDto7UvJS18gmLgE64qG7gy3noDhj0t1ZKYiya4+xhmXi9I0zqqpgqHt9+JXhdhLoxEPMiTanGtNGfX2LJjdtUyo+csEv2vGWg2C6TDKhbzykrv69hH1ItIKt56aHsp20zn7pQCN6+43LNItjupqu9wp1iF1nceydoz7emmfMdplpbKRQPqLVUYwvuMmgLhoxjvDA6LcKWg1fKF7FVUgNuI7Od/AcDKtSGokqbNABQB463cdpgOM07WmqLK54YpHXD2dYVs5htpU+6xoExaT/JUIE7MYdskD7Fk0oV85y6WuBxA9e+f5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751628336; c=relaxed/relaxed;
	bh=9v5qrwIow1mSXRgCQW0q0a2irFUlXUtfntYe3d0Jxh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHO7PoGsBzgmQJzwK9DcKHd+rO4iZawuGCKcTxM1ZvQBDwcPS17EskXYfrGzv9RtwTqzhSx0nxfkSptczy7sqD2qUM97rKbAu9zNSO/KDrWKzMoIhczq3RDEIYkjHOU3cqTDDIMgQ8dieHM08EQsILi86CFo+Af6ZW5j39tEwfD6XqOB++JQ5NYWeY6h0yDoq29qhnytr14HUTcrZL9vfMqhCYlLOyZak04LsUoha1dTjHh9GBJz+o250UWwrQ4u27R5DwGj3m1X34YLur+cADSA+KTMWL/mHrMgBnubh/eBjaWej7QxgQbqVKshs76a1S8xWWC/jtts4s+H0rHy7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=prgCVUGf; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=prgCVUGf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYWXJ1rQjz3bqh
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jul 2025 21:25:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A15E761454;
	Fri,  4 Jul 2025 11:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F79C4CEE3;
	Fri,  4 Jul 2025 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751628333;
	bh=rpBSB4vC8J/yzro6d6f5bj5eJ9yNHud6GzBh8/h8HtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prgCVUGf9iFPdLL0mwZDF5Xhg/XUyJNinoCj3J4qw5siOiRw/POQ1+Qpjgm+uFivX
	 OLKorPY/idVAbQ90DqwfT5nlc2EBEPcSRxE7IUdyF/hjJHnGfIWqbE59eGLjWpbkhW
	 V84intNbfds/W2sbxUTPuCQpvK1b9pdfnYWZNTatvXWBK3qAljoD1ZvyiEchAbIMO7
	 vjsBMVs7tZ3nTyCAMRxlPI1Xxb9HZ+8mOfMHtaop745ud1zsq4Zm4BSFNYRcQtUUxQ
	 9iGTvruV/nrddVBU3xHQ6PlpUK3N+s2rZQQ/6NvoImKBnzzNW4remettyGn1kSoS+L
	 xsg2y/YxvLwmQ==
Date: Fri, 4 Jul 2025 19:25:26 +0800
From: Gao Xiang <xiang@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>,
	linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
Subject: Re: [PATCH] fs: erofs: Do NULL check before dereferencing pointer
Message-ID: <aGe6JvgS6YDzkY7p@debian>
Mail-Followup-To: Andrew Goodbody <andrew.goodbody@linaro.org>,
	Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>,
	linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
References: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
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
In-Reply-To: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jul 04, 2025 at 11:53:18AM +0100, Andrew Goodbody wrote:
> The assignments to sect and off use the pointer from ctxt.cur_dev but
> that has not been NULL checked before this is done. So instead move the
> assignments after the NULL check.
> 
> This issue found by Smatch
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks!
Gao Xiang

