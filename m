Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF275F152
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 11:56:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690192611;
	bh=am2eIoStEhYj6reS+R983QZxh6h3W0xYr71gNNToCQ8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JKGP6a5c603/8QAWJlCsK0+c2nwZCwDJXwSTRwrnrAVLdq6748E/VxXTGLaxJF7pv
	 idKUVebq4QsZKUbjduLvLm4ajvTgb4in+jMKIvKs5+u9mjagP6EfVTnhwqNEAZ36Ed
	 /Kx2ugFP1os0Ync+UQ35Hvf85IWax0jqkJD8u1VTttWhcs9/CG69Mv0v64hy0t555x
	 1XQ+Z0qVrezCAIH2aksKRm861QFWO5wQ+dMJtY2U7W3u+7OyI+2AhFE2Xx4N+8QiN7
	 UtU+MzMmXtWvUSJUy5G6uY/l/hjJtzOka6GQwS9Qf7Q+OPbGA8T1WPK5HdlDrQbA8l
	 +dLh+yczS5/gA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8bD35r3hz2ys2
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 19:56:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OlJHj1/y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8bCx3js9z2xSN
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 19:56:43 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-682ae5d4184so1051754b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 02:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192601; x=1690797401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am2eIoStEhYj6reS+R983QZxh6h3W0xYr71gNNToCQ8=;
        b=azEeKfw6tRet2VN9NL1MNzG/pnfhoBQgjW/VWd8VVOCgWly429gsju0GL6n3uKrqoo
         ZFPzPR8OZGBh0k5z5xHHGRiOcCgG5+QS9LuPjnQou49s+ck1xhWxe+7ppF7rP75vMcEY
         xhVUpCUDQSc1J8nw3z3B2r25vTTGVsrku1ZsEsP/5YH/bBQ1zkUIbS562Kx1dP0t17hP
         +qtWyCWT1g1T9llP3XZdYnv+aqYQ/pva2Mog3ctXfSYo0MtLAFz4l7VILoX0QVObcaf5
         0AStDim0SKSdUs0TDxNaBI9LQRcnBgjP/5fQmG8bXx28xy4eJE/S1KRs7tXP3RGNYWSd
         2YCw==
X-Gm-Message-State: ABy/qLbAe+0+MrWVA8VXHBeiOrvCXgN1fO3tP7VXI+KA1XToD1jC+QFS
	tEuIBS8073beNxOsoiONDnIDgA==
X-Google-Smtp-Source: APBJJlEtnCzvJ6I1rkWEELadVXHfZtUE/plpWIuGp/MFKpOvTS509ssN84iHDxA1POdeL3+D21rKQg==
X-Received: by 2002:a05:6a20:8e04:b0:137:3941:17b3 with SMTP id y4-20020a056a208e0400b00137394117b3mr14532126pzj.6.1690192601020;
        Mon, 24 Jul 2023 02:56:41 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b00682aac1e2b8sm7356787pfn.60.2023.07.24.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:56:40 -0700 (PDT)
Message-ID: <7b4eb3fa-1ebd-de07-1a16-9533b069a66e@bytedance.com>
Date: Mon, 24 Jul 2023 17:56:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/47] binder: dynamically allocate the android-binder
 shrinker
Content-Language: en-US
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
 cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
 gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-6-zhengqi.arch@bytedance.com>
In-Reply-To: <20230724094354.90817-6-zhengqi.arch@bytedance.com>
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


This patch depends on the patch: 
https://lore.kernel.org/lkml/20230625154937.64316-1-qi.zheng@linux.dev/

