Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702D33B0F5
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Mar 2021 12:24:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzYwX2x6Nz2yjP
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Mar 2021 22:24:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X/Lq2yrp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X/Lq2yrp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=X/Lq2yrp; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X/Lq2yrp; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzYwT6CjQz2yRF
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Mar 2021 22:24:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615807461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Djr40beaGeWrfSFbq8+OWk3jVJgTwdTUkjAhT7wUxI=;
 b=X/Lq2yrpDLQkMAzmhDdtkYLGtqny9Rb9R5Ee8gO4l9BJRzENjzIAOu5l7sAQNdPLRE5FxP
 6G8GHuryW28ORMtUXRV+u2l6Pqx7E4x7oSEfWKBjTpvhFIKu4GFxq1QE2slBpVflfKq2YN
 Air4lFIxYNYdkQ5eIDtV0RafUcfRPlY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615807461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Djr40beaGeWrfSFbq8+OWk3jVJgTwdTUkjAhT7wUxI=;
 b=X/Lq2yrpDLQkMAzmhDdtkYLGtqny9Rb9R5Ee8gO4l9BJRzENjzIAOu5l7sAQNdPLRE5FxP
 6G8GHuryW28ORMtUXRV+u2l6Pqx7E4x7oSEfWKBjTpvhFIKu4GFxq1QE2slBpVflfKq2YN
 Air4lFIxYNYdkQ5eIDtV0RafUcfRPlY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-k2jsa9GNMx2MKLRhLdCuLg-1; Mon, 15 Mar 2021 07:24:19 -0400
X-MC-Unique: k2jsa9GNMx2MKLRhLdCuLg-1
Received: by mail-pj1-f70.google.com with SMTP id oc10so14350845pjb.8
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Mar 2021 04:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7Djr40beaGeWrfSFbq8+OWk3jVJgTwdTUkjAhT7wUxI=;
 b=sVoDWs/Jxxfc28NZAr88zMs7AMipaeHS9cf9C5aR5DzJLBOQ3xnytqk5AjAOQrMHzX
 9aq1V1euAFB8/DwXSRsJksDIvZCgdfZNUmKmhew0T4OVS3bbnnVloorSfUuU5BxNRRSx
 YosPK3sXj1NKiXStqaazyoI3cHYMdnmt8dkcs0oKPli4rq0OWNJL1fJQKKJ0CeVdYjM5
 135V/R6FE48rFDNykCuJCkeVYNS+HKPD1Wfa6+LuYVLn2rv3b3X9XHPDrCpWFDfmLCXE
 JkPqBAqiso5DFiEqUWYW05RSkvuf/edJhzwq6imEm4z0LyTFoiW+zjr+jRmc/Wh13oCV
 WjOQ==
X-Gm-Message-State: AOAM530Gme/Eus6nIhATGmeZNUmWA61aWcG+PIvxIDFHgjOpRVHaj6ir
 HFhzi+mhbtnp912k4QPZFVlf9v8MYDuVKyDm2uqudzplEnKN3Y1niFlzpbAIZnq8LwLM9AeCgM7
 9amvIDxbPWJL6E+bXdxJjVRZR
X-Received: by 2002:a17:902:ec91:b029:e6:90aa:24de with SMTP id
 x17-20020a170902ec91b02900e690aa24demr11008541plg.63.1615807458340; 
 Mon, 15 Mar 2021 04:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIitvZrdUzlaIbOdZchSoaAuYKimnbJJQE6hRD5fYanFfh+YuwpjLDpPgkVCD9jVV6piqWQQ==
X-Received: by 2002:a17:902:ec91:b029:e6:90aa:24de with SMTP id
 x17-20020a170902ec91b02900e690aa24demr11008524plg.63.1615807458168; 
 Mon, 15 Mar 2021 04:24:18 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id gk12sm10830473pjb.44.2021.03.15.04.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 04:24:17 -0700 (PDT)
Date: Mon, 15 Mar 2021 19:24:07 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v5 1/2] erofs: avoid memory allocation failure during
 rolling decompression
Message-ID: <20210315112407.GA838000@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305095840.31025-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20210305095840.31025-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org, guoweichao@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 05, 2021 at 05:58:39PM +0800, Huang Jianan via Linux-erofs wrote:
> Currently, err would be treated as io error. Therefore, it'd be
> better to ensure memory allocation during rolling decompression
> to avoid such io error.
> 
> In the long term, we might consider adding another !Uptodate case
> for such case.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

