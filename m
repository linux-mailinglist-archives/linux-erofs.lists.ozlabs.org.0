Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C976E968268
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:52:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy2Zk3RCqz2yNc
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:52:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725267161;
	cv=none; b=cCyz/6x5iF9u6a8ULDmFVnq5Y9TlWNG0yBOAgKRboz8oCbgNMMF5LCNMlav9s3vcte3OEZyLSloLhdKc4k6vY96Jfee+jltOONcX+yciI90Zl5mH4QEDPKG3fhvIQbM11UIsjEehF6UAWTOr2iDrXo/vAGAetKlQfvubBc3SzDN0+6u0SnA8S9h7B9NgPXPexKVZT3fOD3aQycDU5t0/CnoZcQWk667kn/XOGLE0W8IJDg6Xm7p7nVPQeCrAD7eRAdV87HKaIYBT7F5IdmknJjhjgd0kE3oheTDgnelmB47gIfsQVayfhgKnhTYBihKhQAItwkJGBj5A0JylugeLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725267161; c=relaxed/relaxed;
	bh=FCVpVC6gi7WatC9sJUp9nRqX9Z7VL4I3Hg9WX2Ak+JM=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=EZmiueF3HfLkY9y8Pc+dDTduQQtEE7kK90WsJbMniaoyujRLH35233Md8qc3ZdTbOYF6bGe5xOWF7e/Kdxi2RshLvhx6RG9Iu5C36tD5sNZcQILnzOT4XeB9jQoDiVCSh6wImRAmkCSe7+pN27gBZZP29CEKZMdBTWVm9DBedxBM7kO60/tnjJf3fhdPhALo3gJNkZZk+QSWPZBoxUVUkK6NGRcxj/h+lKO2Yexj/I+AJ3ZpY5HPedls744em27rdWd6ZKA+jiNZ79iu0B43cInN9O6C8hzX2zSQAVgBMu112kDgGchhbJ6nmMZ8/ph9n8QzbNAQuLE1TK3nq3VIbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Us1le5pL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Us1le5pL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy2Zc0ym5z2xfR
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:52:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725267153; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FCVpVC6gi7WatC9sJUp9nRqX9Z7VL4I3Hg9WX2Ak+JM=;
	b=Us1le5pLt+M+UvumQccBsv8Da0YehZVjPN9xixS0eDUksxx+eQywkN4+G1OlGqSTT8VeI+E35lmP32CccaIIzZC3Kjo1lE7bUlZvXGFs94v44tzM7JkrXGc+5pCS8xdP3hsu5q9T9lh6Ljlz2iuRp+ultEcZ/AJ02JGRhJVKzr8=
Received: from 30.221.132.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE6HxRv_1725267151)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 16:52:32 +0800
Message-ID: <5783ccbd-34cb-4f1b-8376-d795df2db4e3@linux.alibaba.com>
Date: Mon, 2 Sep 2024 16:52:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Yiyang Wu <toolmanp@tlmp.cc>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
 <20240902083147.450558-2-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902083147.450558-2-toolmanp@tlmp.cc>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/2 16:31, Yiyang Wu wrote:
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>

If a patch is unchanged, you have two ways to handle:
  - resend the patch with new received "Reviewed-by";
  - just send the updated [PATCH 2/2] with new version
    and `--in-reply-to=<old message id>`.

I will apply this patch first.

Thanks,
Gao Xiang
