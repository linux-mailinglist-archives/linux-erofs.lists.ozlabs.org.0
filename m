Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 468846447B1
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 16:12:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRP681Fpwz3cLB
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 02:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=maM0tSGE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=maM0tSGE;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRP162Wgqz3fGJ
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 02:07:54 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 68E586178A;
	Tue,  6 Dec 2022 15:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12406C433C1;
	Tue,  6 Dec 2022 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670339271;
	bh=LGJtkj6tlGm0S+Vo3HnJFB6nv3mejW6xah3eFnKfR9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=maM0tSGEdV832IA6va9/TFSpx3eGgDMlq9rxHsTwKsR/lQQUDoXXPJVYk9KkgollR
	 yvjJeXovP5/6H8gM1Uq0J5flUJz3WYd9YuIDZj1RvBHO/2ObKvHzgV06XVHra2aHcj
	 MRImEjjlsA0YmGp4jdk8M8/Bj3+iJzY6YwQohPWETkc99Eqa6Q3cKbYbSmlrXA0JU8
	 DH+En/2seBXCIX77fbMQOlE6kkC/9DVFCke72rScBx5aFHjX+f4+F/vE/tyK7fn9N+
	 eqZXwoWYD47EBpgi29W9uLu/0mmnMNly9LTt6TGLNgeI0GjkPdJR8xrtDv/TFNLtEu
	 Dv5UgTTuP2Bew==
Message-ID: <b188931a-decb-3476-f22c-d580fa4fc840@kernel.org>
Date: Tue, 6 Dec 2022 23:07:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] erofs: fix missing unmap if
 z_erofs_get_extent_compressedlen() fails
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
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

On 2022/12/5 23:00, Gao Xiang wrote:
> Otherwise, meta buffers could be leaked.
> 
> Fixes: cec6e93beadf ("erofs: support parsing big pcluster compress indexes")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
