Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C982E5E5894
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Sep 2022 04:30:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MXzlh4lggz3bqT
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Sep 2022 12:30:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=x2HwAqVZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=x2HwAqVZ;
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MXzlY4Hbbz2xh0
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Sep 2022 12:30:15 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id b21so7467024plz.7
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Sep 2022 19:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=6RwGBqc6lTnE7JnqV8OurSGJbwt84FPwXV3SLopRoPY=;
        b=x2HwAqVZD+z4C81oJd8Mao2bwiUx320Us4SBHRBWDStYqKIpQSa0EfdfZ3fJV3taov
         UhiqB99Xgoz77b8C1DxPgFKbAl3fYWZMIHkYqXFt8YRJqdcRmIKQnB7CLz+Hlscf/Zvx
         BhFWxW4dqGP5x0jA4PWwmIyERpkbfgfrFe9OSWmsQ3K5nVlR4d7PwAn7Kd7SnvGLO77x
         lmLNmDYJBzT7KRHqUmpGNMX9KhCMRs/EDjzkdOeTE8+IqM/jRCQuNWDxmAetQe8xHDMN
         sqpuSNRi9YR01Y0vCbpw49DZaGqyWiQiOrHdc4cB6B6mik86psZS2PFiSyjG/RsGU8fM
         R9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=6RwGBqc6lTnE7JnqV8OurSGJbwt84FPwXV3SLopRoPY=;
        b=VWt7ow4xe0i1t4sMSsDMhkcuhmyRQDQTBGc/SUqOh7zg0Lu1IDqsJr1XDBEgUdF4hH
         q+lwha0M2tvR7vDTJYP2wxNa+Hcz2H5hU9uYkFc+KTTBNrllCpzY43H/+yAOh0ooXyRl
         b4O8+HDTPm9hxS5N9E8NyYIe6OHhJFMHRmGrU+X4ZxNSgsxTlTkZ1v/SMkxKFym7Xe9A
         iWgtv8E6RU7E9Q2cQGXZbCE2rNRw8ss0coHoKma4fKCf5N550cHkeq50Z4wEtO6ELS0Y
         CcEZ2gbTrBS+yeGQnXEfW+MCnKISflDNzyyQtlT75r/HKeNJyp5ooy8c5IxA7k5u9oyC
         Qwyw==
X-Gm-Message-State: ACrzQf0GkReWDV5zQIeeXvKS9Ft2bBGfRj1xsP/T3gLBWyKh+hiZJnSW
	wLGyxSkC9DPHjOgmH/3rtHXvxA==
X-Google-Smtp-Source: AMsMyM4tGm+YFHhT0cBVSCmb0eAR8+OFN6qd65oC4gAJts0CdBB2wLTikF/9+gclpSPbsfy5sd5TqA==
X-Received: by 2002:a17:902:d355:b0:176:cd80:5b32 with SMTP id l21-20020a170902d35500b00176cd805b32mr1114681plk.68.1663813812401;
        Wed, 21 Sep 2022 19:30:12 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 65-20020a621744000000b005289a50e4c2sm2947085pfx.23.2022.09.21.19.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 19:30:11 -0700 (PDT)
Message-ID: <72672db2-7fd4-2912-35bb-174c09a74600@bytedance.com>
Date: Thu, 22 Sep 2022 10:30:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [Phishing Risk] [External] [PATCH] erofs: clean up .read_folio()
 and .readahead()
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20220919092042.14120-1-jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20220919092042.14120-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2022/9/19 17:20, Jingbo Xu 写道:
> The implementation of these two functions in fscache mode is almost the
> same. Extract the same part as a generic helper to remove the code
> duplication.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>   fs/erofs/fscache.c | 210 +++++++++++++++++----------------------------
>   1 file changed, 80 insertions(+), 130 deletions(-)
> 
