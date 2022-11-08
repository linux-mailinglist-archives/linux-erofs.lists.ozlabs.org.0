Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B028662074E
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 04:09:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N5tPK3XDxz3cJv
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 14:09:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Go9X8vIy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Go9X8vIy;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N5tPD3GYJz3bj0
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Nov 2022 14:09:36 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CD7E761380;
	Tue,  8 Nov 2022 03:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D04C433C1;
	Tue,  8 Nov 2022 03:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667876973;
	bh=ESaSA6P2k4Dk/Y5lWn22BcQjULKGCM7blKLusR3qWEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Go9X8vIyiPTW7Rf0ol54sh23E+uekMG/Bf6R1kV95NsgAT1IbNOE3aXtlVsunGkZA
	 C0icvDImDnBH5xu8cX3IK4Zs2iVJ0xgBb3LIkThRYFOl5sXETNz5w9EUaJB+I+uQ74
	 +03aIE1yQTL+FkvrJs9UQhxiq+XMNQ7zl6SjoD1jKTP+671xikd/uMXni7ly4NSw0I
	 EUVfFW2HtBWbh09klD4Fms6adjxRTqYWDZKM6VsVSsqeP3zFAjNBZGsT6esHqHVS3S
	 U1vtqrK1PFptFCn246c5IUHk0Dm/ruhrPHh+uZb75Yte7k7OWEBvsWIzf2h54PeRbp
	 akTxK9cv5Nc2w==
Message-ID: <e288944b-559c-e184-96c4-370a80cbb9a9@kernel.org>
Date: Tue, 8 Nov 2022 11:09:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] erofs: get correct count for unmapped range in
 fscache mode
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-3-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221104054028.52208-3-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/11/4 13:40, Jingbo Xu wrote:
> For unmapped range, the returned map.m_llen is zero, and thus the
> calculated count is unexpected zero.
> 
> Prior to the refactoring introduced by commit 1ae9470c3e14 ("erofs:
> clean up .read_folio() and .readahead() in fscache mode"), only the
> readahead routine suffers from this. With the refactoring of making
> .read_folio() and .readahead() calling one common routine, both
> read_folio and readahead have this issue now.
> 
> Fix this by calculating count separately in unmapped condition.
> 
> Fixes: c665b394b9e8 ("erofs: implement fscache-based data readahead")
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
