Return-Path: <linux-erofs+bounces-335-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B9ABA0DE
	for <lists+linux-erofs@lfdr.de>; Fri, 16 May 2025 18:39:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZzXpl5QpZz2y3b;
	Sat, 17 May 2025 02:39:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747413551;
	cv=none; b=TJVXvsxm5NaxvUHIFXJox58HbpFQJrNd7EzO6Ocg9ztiWzfmQ4KMawZOj3E52eFLpRfx678VaGH9W+vLzP+I2No9lpIgDdJpY3DbZgJwp/AMXyPBrbXqVQy0mFm8er6rAVPmX8g8n7CNkkdma0qoA3IY3gM5LVHl7PLw9rJlDsw9sEenfMeSLe55CieSWjiLhgv22vqJj9Wct03maqZNVQvIEdtN9fGLUtkXKIV4tlnevnoADbsBTo+baTJ7lcTyq8FoC0VhGiz/1m+XuqPzFb/EY0uhsBUz75YQhkDBlPyYupPFu3EO+nupMtx+SQXqrHlA5jFlIyaBkT3wgUIrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747413551; c=relaxed/relaxed;
	bh=kTIt9y83Of7I6eKdQnk4RPzXmuixaOdPHDNjGpqEHPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzeHQfsMbjIGdu2MI8vjW/TBG5GyE2Uow68HNdlStlzZycLBove/lCAxKmxweV5kfms1EmA1w/6S7C4X4uO5oASYdJgnd1xnQX2u+9faW8g74tf+1eEuFFUdBI8PjvuRuXponGBh31ifgetPGaI0hGFU13UqFBITk9VlXQBImqH8UpK/GPTV8Ls0vwKIavhrXM+4l3hLaZNXAV4U6mDSeIN3NmkK7n/aoFi2jN/w2DBzw5jGe+K/pxVktnhOVy/ihd5rzJ+y9fYAmpCuv5omztgzW5saQc8sGM09brW9KN3lHDGOjvV9On62qhO+1ugF/+2Sd3dBCY7CdidrRxUgqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aW7fRs3P; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aW7fRs3P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZzXpk6gnFz2xsW
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 May 2025 02:39:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7F5D7A4E987;
	Fri, 16 May 2025 16:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ECFC4CEE4;
	Fri, 16 May 2025 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747413546;
	bh=G/Cy+Bz6hayBNwZP3XSh3lfBwyeVvC/aasljpHJTH+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aW7fRs3PNNcYzDaWOR4+i4b+ak2VmjQRQ0KxdIpxEqjBAGEtMBU67/nGRQ2OCnKK6
	 dUKJCdC3DBC4P+wI0u9gNs1fhOJ7v5w6NEWqaWkvq+mQdQVrMPABsoRXcV3DRz6OJk
	 cDL7cy8oS7DwFa0gMtAAOE3E3BCxPbSiVd7OaJXpdYNVBraf/b3qQlOW46XHvUWpqe
	 w6RAMcBY7ZmwgIxjNaR6WOGxzLiAXmdnsCO/AfyYfwhzrp/ECXD638Ch6W1vTyfVV0
	 THbCfKGq3rIbAXx7+lyFyU2H9rIFFZ1orQwiDBxkRLjhoiTskB51l8JBvrnwmV66Wx
	 38eCTwa/+ZSyw==
Date: Fri, 16 May 2025 09:38:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Bo Liu <liubo03@inspur.com>
Cc: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] erofs: support deflate decompress by using Intel QAT
Message-ID: <20250516163857.GA1241@sol>
References: <20250516082634.3801-1-liubo03@inspur.com>
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
In-Reply-To: <20250516082634.3801-1-liubo03@inspur.com>
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, May 16, 2025 at 04:26:34AM -0400, Bo Liu wrote:
> +config EROFS_FS_ZIP_CRYPTO
> +	bool "EROFS hardware decompression support (crypto interface)"
> +	depends on EROFS_FS_ZIP
> +	help
> +	  Saying Y here includes support for reading EROFS file systems
> +	  containing crypto compressed data.  It gives better decompression
> +	  speed than the software-implemented compression, and it costs
> +	  lower CPU overhead.
> +
> +	  Crypto support is an experimental feature for now and so most
> +	  file systems will be readable without selecting this option.
> +
> +	  If unsure, say N.

I recommend not including the word "crypto" in any user facing part of this.

Compression algorithms are not cryptographic algorithms.  The fact that the
interface to access hardware compression accelerators is currently the "Crypto
API" is an implementation quirk.  It could be a different interface in the
future.

Call it something clear like "hardware decompression".

- Eric

