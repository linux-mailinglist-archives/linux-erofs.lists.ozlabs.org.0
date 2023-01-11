Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669366563C
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 09:39:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsLgx20CLz3cDT
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 19:39:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Vk1nCDzz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Vk1nCDzz;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsLgr5NNnz3c65
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 19:39:03 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso16357361pjf.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 00:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPVH72R3ba+4/jywBCJ353gkE/PRpDfS0ZKHVcpVoJg=;
        b=Vk1nCDzzWKHoD8BcG1t4eJFJDX8KhzywpXjnk2PZkOY473wARKOFyf/6JO7cNvsN+w
         0VLzLHE1wgKMp7TLyGHQZHiBASZBf+F/EUjhNR5aXvU9hhlP9rW3vtqW2gaUb8CcJRX/
         1BrtPMglqrZn7YMjC0BgL5EuC9UJnFMsTTJdU+FdjUOH9URApGyJyS1B/0PYnILYLYeP
         5BCcnZpjvugReB/ghNUSmdY6na64gsmFBPW/qHyShIJfE4qTMys0uv6pz/wQJkgHuSZz
         vuzk6AzzBDCOvrV0gTqjAPgnCkiqWoD7Lh0W4WvkarAbqZ9gx8C1QNLByvYizvmh3nJh
         CTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPVH72R3ba+4/jywBCJ353gkE/PRpDfS0ZKHVcpVoJg=;
        b=SoN8w6jV/zJFcpvriy0F05Z/rD5FtEuEZUcENQH32590OSvVVCqaWsazyDCPJTdQuF
         ZQnF8PJRQ1j0odyIueom4nGSz4b1Wt1T6upbJDPDxWnA3QIePxcGYVLj0Fxa0FFP/soE
         iLki0w+Fn7PT60OOhNJIMUGnZ7oMn1HBXsTLxdG4k6bD98Ym0jz44vqAvxYKvLknmpYt
         ahAqS30jqRrMvUqn0HpacxehK80kjVU3oIbNE/lRe8tyzyDXtunNyEV+tmEPnszu/ISp
         G6Hacy+jpzoDzhrEzJnjAMihWn4/24lZCeorKi61V4gqCluNlb0y0wXgs4ndVGThXkbA
         0VOw==
X-Gm-Message-State: AFqh2kqwFCCY8BGHk9F9vA5h5YZIdS34aJ2jRvzlthMcA438tv7Z7qE2
	tnDzfvOo1pVzf9qUEOiW2G3rjQ==
X-Google-Smtp-Source: AMrXdXvhE3M5MuSxBNKiXK2cSusdZt4PCf4gznPg7QU+DSnMdcAKBJG2/ng80lh1oCmgjCBmP2/qJQ==
X-Received: by 2002:a17:903:428b:b0:192:feeb:b06d with SMTP id ju11-20020a170903428b00b00192feebb06dmr1563042plb.62.1673426339301;
        Wed, 11 Jan 2023 00:38:59 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902cf1000b00192c5327021sm9543148plg.200.2023.01.11.00.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 00:38:58 -0800 (PST)
Message-ID: <61a92067-fd31-f89e-dc5d-6efa2df1dfa9@bytedance.com>
Date: Wed, 11 Jan 2023 16:38:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] [PATCH 1/2] erofs: add documentation for 'domain_id'
 mount option
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20230111081547.126322-1-jefflexu@linux.alibaba.com>
 <20230111081547.126322-2-jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20230111081547.126322-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/1/11 16:15, Jingbo Xu 写道:
> The share domain feature for fscache mode has been merged, and let's add
> documentation for 'domain_id' mount option.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Thanks.
> ---
>   Documentation/filesystems/erofs.rst | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 067fd1670b1f..958cad2c4997 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -120,6 +120,9 @@ dax={always,never}     Use direct access (no page cache).  See
>   dax                    A legacy option which is an alias for ``dax=always``.
>   device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
> +domain_id=%s           Specify a domain ID for Fscache back-end.  The blob
> +                       images are shared among filesystem instances in the same
> +                       domain.
>   ===================    =========================================================
>   
>   Sysfs Entries
