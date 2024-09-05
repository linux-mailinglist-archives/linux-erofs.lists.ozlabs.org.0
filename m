Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA796D3BB
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 11:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725529506;
	bh=9Z3Ei3DEigCodCwQrhCkajVjS1tLfO53+fZou9ArGDI=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GshrKhj6lWYpPSydG2rrYqRaQiubnlgbgNFGm3xYhOB+zkB8yZeVM76R229k3uB8A
	 VCucJI9Zyx86w3IvwmhNcKa5Bs4ATZT89rH+AiIAhY7peoxDluD0qK/ptR6w8Xcd7X
	 SK101qaePIO2TRyCkFyXH5ArAxaKMAOmfe6iT+QWeG7lxtthhsMARW9Xl/lLgIe71l
	 dc0bkLHrZQ0R9TeewIjJgo1624fMWMxByl/VYdmcdTT9BnT09tj1zZBry3RHW2NHmN
	 oNYF0LgIvwt/sl7N9DejTM4pG1nx/8qwLDJQxoNcmSMyitot4H8xl18JL4q05hYdTH
	 gUZeQbZyHbVtg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wzvbk2Wlkz2yvj
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 19:45:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725529504;
	cv=none; b=Qu83ZlSvreKpYLwwlpyZPtPOZFdBTBwm/ulCU3lYr3Koq6xyp5Us9pxZrPnoamuwSEHBRuB0kKMmI6P87IeKRClDc942sGF5hd/FphDxPH7pCe6JA25Ywp+088EI/BLkw7X/tYejIgFJuWjI1mCU/3eUx51T9JpCVr2JABu7D1ZWWNC/uZYsyL7rUlKL5Pni/IH+PUm2EGr+utx9KrIOq96Mj9YBq9YiWTmEAPV0gC4ZXP2lrtFDfjkikM2dJ269yj06kX6QmNp/JLi5IO/iFV8nB5pNPsScV9+0WRdUkpvwRDRfwph2nBXUQbSuLDHTzAHtLS7ISr2GN1hT4GC/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725529504; c=relaxed/relaxed;
	bh=9Z3Ei3DEigCodCwQrhCkajVjS1tLfO53+fZou9ArGDI=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=Sgs+6i8rkF1M39zg9LwvTe6dNWgut6IDo1tJeKdG+I2CHRMLi6Hq2Ybj+VvPt+TSHccF2PV6Vfb9BXtO9iR3PFjREw4Nd7q+rRq4vSYTi+xAPcAl3vsJN8Hd0UMDWRxlQEyrKaPiPYqITdDPL17Y4OzcnxDrcXnqekHwsQNjhgr3VZRUHd2rdP+XrhAOfG+Oi96RsUxmAo/FbqvRk3bwMfJmOlQAf32wO/Y/rWCFacbt+8RjWmO53oxI7ikCpIkJ896YUVOr8zC/NqUykLIhzD89HmS5mrpBplGr+a+3Cb2zFpJY7fiZ9LZd/ZmI/u+v3xmADRc/pJ7jdHayioiOHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=geJ9RRlf; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=geJ9RRlf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wzvbh3n3hz2y8W
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 19:45:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4B8ADA444D1;
	Thu,  5 Sep 2024 09:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97210C4CEC3;
	Thu,  5 Sep 2024 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725529501;
	bh=S5ymXpa1KOgwMsuMGp7XboDwi0bCDu7KxdYDFH+QZ7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=geJ9RRlfKCgixR4Jx6yPhanHIgA8bBlWNti3bWbEV9jbRWoD8wQfGVR0XK5uCvvTR
	 /hvzATYq43k26bTCdtGlQUGMtlEi8PScftA901sVVMlsviSCLl/dGrf+8gTUNzzBxh
	 35jkuRdt8ypBG/X1t2DqXBtxM2+gxgBA//37VrE65ESreDk9lrUx0FD8pMy7A0kQKB
	 dktdT+AvZFO6QlIWnwaEYrf/w/ViI8ghxx7b32ntzrp/JIcalnByFppUYzl2AA6gke
	 H+bJ+fAjlF8ImHRqrIh+pf2sVdFKu6zBeuZ73/ZpsvsNEOYgO7sbMoJhIH3WmgrNZf
	 H8aB9vy2+DmKg==
Message-ID: <c73e424a-851b-4bb0-86ba-46acdd7cbe25@kernel.org>
Date: Thu, 5 Sep 2024 17:44:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] erofs: support unencoded inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240905093031.2745929-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240905093031.2745929-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/5 17:30, Gao Xiang wrote:
> Since EROFS only needs to handle read requests in simple contexts,
> Just directly use vfs_iocb_iter_read() for data I/Os.
> 
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
