Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9F52A73D
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 17:43:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2gQP3506z3brS
	for <lists+linux-erofs@lfdr.de>; Wed, 18 May 2022 01:43:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oHYpg1eI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oHYpg1eI; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2gQL62Lkz2yZv
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 May 2022 01:43:54 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5099DB81A0F;
 Tue, 17 May 2022 15:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E4AC34116;
 Tue, 17 May 2022 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652802231;
 bh=Izy6TZfGaIzRY1Pn79tgD0UhJ4xSdDmIRaB4G29KIh0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oHYpg1eIXlXWIxkNISi8Q7gkc/zKuqBeSbJdtRoeIk4ByEIwPH3C7yZHEqXgzbTlS
 BEP9Bufmhpyj2rHhnwPJbmjde4BVNpHGUTFKd15O4BDWpMUyc4gKZIR9CxuT2D3fo5
 XJ6fsJ5lFo7wmenRyebOSS+ISW0r1VNLJGhM+PlhymPYNu/x5TlsYAGPpF41Iy9JJ1
 khjFILpzL7rYRVfixsWLTGLgioLiUmsjp6r44Jon5ifS78+NlZKNnBvZ61oDnUNzpf
 WkBAdeKNrFaVYgaWdAHjEwe870dDhFGv3R5ccoM8JVT5rhtkGzrtkPGnNlsee8XpuA
 nUD6DWnyQKEIA==
Message-ID: <14e765db-5e51-9c17-3aa1-bddc1ba5bbb2@kernel.org>
Date: Tue, 17 May 2022 23:43:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 resend] erofs: make filesystem exportable
Content-Language: en-US
To: Hongnan Li <hongnan.li@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
 <20220425040712.91685-1-hongnan.li@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220425040712.91685-1-hongnan.li@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/4/25 12:07, Hongnan Li wrote:
> Implement export operations in order to make EROFS support accessing
> inodes with filehandles so that it can be exported via NFS and used
> by overlayfs.
> 
> Without this patch, 'exportfs -rv' will report:
> exportfs: /root/erofs_mp does not support NFS export
> 
> Also tested with unionmount-testsuite and the testcase below passes now:
> ./run --ov --erofs --verify hard-link
> 
> For more details about the testcase, see:
> https://github.com/amir73il/unionmount-testsuite/pull/6
> 
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
