Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6E483D93
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 09:02:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JSlTP0q14z2ynk
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 19:02:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FEhzt3sp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=FEhzt3sp; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JSlTL5pgTz2xDY
 for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jan 2022 19:02:30 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D6B48612E7;
 Tue,  4 Jan 2022 08:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C8DC36B02;
 Tue,  4 Jan 2022 08:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641283348;
 bh=QLZ6g2Ht0oArjMp/a0AaWtON7ynpwARL5ppGkT5fh7A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FEhzt3spd6tV89XViWZVhiGUVk9wmZHNgCl+HjA/iT92QUVZ499xqF9GLno8Cq50z
 FKAMaUZLF8TBGuPKWZ0ZpgVZ4XUcBs+oOsqinvuRubhZGcNfnLAZAAIuDSSZwHTaM1
 VoHh7suNxzBGZOiiY9rC1N8bO9Fqbq29Di+50SqIoJE04xeQImo14kTC8OqwMh6e1v
 xg8hI+XzYTwaYHPpbU0iTKw3CkgTW3+deiwhIb0C5h0LJXq2c361j2kBDn71Wa3GAR
 JzsRme55OMXOAwoM7I4QvUd2BbAabNN3VW/R4M6CfarKlstWO/4mR+ZqQ+nVlgQhc8
 TuDl6bxu0SOQQ==
Message-ID: <6151cc84-f2d2-f9e9-7884-567f202d65cc@kernel.org>
Date: Tue, 4 Jan 2022 16:02:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/5] erofs: use meta buffers for super operations
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Liu Bo <bo.liu@linux.alibaba.com>
References: <20220102040017.51352-4-hsiangkao@linux.alibaba.com>
 <20220102081317.109797-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220102081317.109797-1-hsiangkao@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/1/2 16:13, Gao Xiang wrote:
> Get rid of old erofs_get_meta_page() within super operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Reviewed-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
