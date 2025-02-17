Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9825A38073
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 11:41:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxK2x2xlwz30V3
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 21:41:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739788904;
	cv=none; b=KHNB58QWKFBTgnImlcmQz7QB71buFpnWe4+eYijJcOyCYJPUWSO8kDTcqRn+idq6dqRibaH71z1j4toTp3KLP9Y45vmAVDb5GbrMgnQSI/s5gbWyS9Joiwfy3qoLijjmIjbkzXnLpGCnMsIuyMdVP/HjsxX61APOIRFKFxK3M2T6MD11ZdAH5S4MB4NpzoaOMv4MTByEEnOgAp38NOIN29eG4/I0xN8MHxY9ON0ZuPvsVc0GunHFoXRioiTHYHtEdgPFKkei06NQVzqkD19jbGZDF3EuAM/C4yqu+miu8LI8IuuDadb3BzNI2Unn9rj8sPOemnbigEQAfyDDQp/XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739788904; c=relaxed/relaxed;
	bh=XWTpZGqQz/jMkvs/NObnrKteVXldw/miuF2M3tixfjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+ZcZBgZ/TFDxLvjIUD/wBYtMdtBIw0i37RID7nfX8dxDMhbh8gBudYDz9KEuOub9xwusA3FNDGjzvEfZDLhR79BcVEagh2NAXeAF71gX++sa2+va58SvfRhrt8yoyTiTDKDY+SwYW0o7EY6GOniJ5vzW6beqBD9v2oR9nX891AUOl5BEg3/9IDzdhXMYpZYXWI6obrP2aEuTUW3cGrYOCEWRyAIvxvDNIhnDWAxezu82aYWLwD+bO6a3FeJtX2WPWvsbwZRTUPmnA3ecUprppm/DdXrNrXlu2n7njylf6rKon0PPdzLZ9P0adERYri9yYSWW2isPWFq0jYsrcXjpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xgNT32h3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xgNT32h3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxK2t3btQz301n
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2025 21:41:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739788896; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XWTpZGqQz/jMkvs/NObnrKteVXldw/miuF2M3tixfjY=;
	b=xgNT32h3Z6jIVN4ISvQd+/AK0jTQ+lbfO4AI/nedEgmjkpIKhDqE8pzM2VLBMkI+oT7gruD0PAcagEeL7P97nXAxbyPo8CVlAwxEERYcLIaF9IWKMKfjizna0+ooccq9miomWHCoP9ZaMatbWqYEvf/Gcf524ZWefxchuVu7fbk=
Received: from 30.74.130.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPdpnMQ_1739788893 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 18:41:33 +0800
Message-ID: <0290170c-39df-4609-8de1-55695d6ec0ad@linux.alibaba.com>
Date: Mon, 17 Feb 2025 18:41:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Rust in FS, Storage, MM
To: Andreas Hindborg <a.hindborg@kernel.org>,
 lsf-pc@lists.linux-foundation.org
References: <87ldu9uiyo.fsf@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87ldu9uiyo.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>, toolmanp@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/14 14:41, Andreas Hindborg wrote:
> Hi All,
> 
> On behalf of the Linux kernel Rust subsystem team, I would like to suggest a
> general plenary session focused on Rust. Based on audience interest we would
> discuss:
> 
>   - Status of rust adoption in each subsystem - what did we achieve since last
>     LSF?
>   - Insights from the maintainers of subsystems that have merged Rust - how was
>     the experience?
>   - A reflection on process - does the current approach work or should we change
>     something?
>   - General Q&A

Last year Yiyang worked on an experimental Rust EROFS codebase and
ran into some policy issue (c+rust integration), although Rust
adaption is not the top priority stuff in our entire TODO list but
we'd like to see it could finally get into shape and landed as an
alternative part to replace some C code (maybe finally the whole
part) if anyone really would like to try to switch to the new one.

Hopefully some progress could be made this year (by Yiyang), but
unfortunately I have no more budget to travel this year, yet
that is basically the current status anyway.

Thanks,
Gao Xiang

> 
> Please note that unfortunately I will be the only representative from the Rust
> subsystem team on site this year.
> 
> Best regards,
> Andreas Hindborg
> 

