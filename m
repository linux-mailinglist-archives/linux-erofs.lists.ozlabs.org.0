Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB76450DA
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 02:16:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRfWH4LxCz3bYD
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 12:16:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E5YQAniW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E5YQAniW;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRfW95XXQz30NN
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 12:16:21 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 94464B81BE9;
	Wed,  7 Dec 2022 01:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB9C433C1;
	Wed,  7 Dec 2022 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670375776;
	bh=WH+FA+a+dUqjdRUQuQwOTFdj1sDFoyO9Tuet5keAls8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E5YQAniWEyGQdXSVzeh7iVtnUoWwwsWywiQJ5nzWhte2HMdLFkVhthJb4OhWyIDas
	 WoYm6l8+G8fv9YY778zjqgydBLH7A4YJZyTpyOHY4fBX85NLtOZZ46+GtPvW0LZ8e3
	 j4AOnEHXWX06XKfi4tGOddoOoSEiJ5lcJcF2Ukg7K4gUl4is9kNpc6JlgTzKCUvI+t
	 X/tSixFX5UZOYKR+J2KmkgdY6FGQIiJXkjDi1NLoiZBnoo1stCoaCIaQ4Ifl6jbRrD
	 jd/lWFNHNqJvIDhKWUaNDeqCf6pCkDkhgnPUle+ck2lkrAzaCXmEmTaj1uOIF2U50J
	 ya8A8u3Y13wog==
Message-ID: <11316961-1c94-61e0-6995-243c715adcbc@kernel.org>
Date: Wed, 7 Dec 2022 09:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/10/18 18:53, Gao Xiang wrote:
> Convert all mapped erofs_bread() users to use kmap_local_page()
> instead of kmap() or kmap_atomic().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
