Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84725CCB62
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Oct 2019 18:43:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46lsy21wlxzDqZN
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2019 03:43:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FrrMGidt"; 
 dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46lsxv6vf8zDqLJ
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Oct 2019 03:43:29 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id a3so5501250pgm.13
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Oct 2019 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=jsDzHVPutBOb++SlzWuoqbI+8pAcs5Dgk/9IjZ655aE=;
 b=FrrMGidtVdJGloe/5Cp8swu21c+MDkJgXLUu0AHArkj6Q5YGZBg3icn3VFqVolZ+f+
 IojcM2Mv6MMYweU0zVcvHwDNy/uHe4kSVCVQg1bG96d1x0m7u+zsRAXgiVRjmAaha+pR
 V+hW2z+KSaYRU03PNEDnWIX7oIQ7TB9L6M3lWtdOyXL2Pde53pZxZ3FzKwVyyI9gTPCo
 HMnUVfAU1QHa/p8glSTJFCpHet13SxlMmJdZEBUFVFobw07YQxyNM0y7qX1DfoEip4D7
 iiJte4vAKu5CEAbfrq9UO73S661sAUu9LlmPTO49OswD8RFm6ussj7LLYSWXiov0LE1p
 r5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=jsDzHVPutBOb++SlzWuoqbI+8pAcs5Dgk/9IjZ655aE=;
 b=hRk7cAkE4W14pBIG1NmcndRS+VELEAO0QJeJhTfoTkHJlI8ovv6zHwEB4ZtjaCPrxo
 pS1x2K3MIA0Ky3P695gqVIiz30AhEMlYPuemgxTceCfCfvvabTxJFLZxYZ02Kai2R4nF
 W4qlzBfl8Pkus+SOpJLZGO/2YwaKye+vZMemsuWHOpfsTN2SsqIHrmkrMeZA4/gAY+RI
 UvTcEurxyFZ3/IJPAhgNUmSQ8CFrefQfSzln6tHZkNuBayxV1AMsfsSL1Rh1+ZKlW54S
 7rAlRVbnj6rW1zzoN5zwLL3+VTb3TSO6lYJGgMJJDRAbEb589mV5w+n+Cqs8kOCvc+YN
 YV1w==
X-Gm-Message-State: APjAAAVeDbwuJony+HUBs/E2bzCoj+gZjhaxcrT7R+03I5KScpS+v/OV
 2bHfejzrTyEKbSdqPmn4MeHkq4wDZuU=
X-Google-Smtp-Source: APXvYqzz+pxVi3wO6yrRgJDFEbZHgPnDlSTJRDSK0OfsWvVaTopjHtaQVAzZ4sHC/BBcm1sPDBpMKg==
X-Received: by 2002:aa7:84ce:: with SMTP id x14mr483435pfn.52.1570293806123;
 Sat, 05 Oct 2019 09:43:26 -0700 (PDT)
Received: from [0.0.0.0] (li2012-80.members.linode.com. [172.105.119.80])
 by smtp.gmail.com with ESMTPSA id p1sm12805905pfb.112.2019.10.05.09.43.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Oct 2019 09:43:25 -0700 (PDT)
Subject: Re: [PATCH 2/2] erofs-utils: introduce shared xattr support
To: Gao Xiang <hsiangkao@aol.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20190811171049.26111-1-hsiangkao@aol.com>
 <20191005142050.8827-1-hsiangkao@aol.com>
 <20191005142050.8827-2-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <ace894c2-f2f6-9c1a-80d3-045bdc9ee0eb@gmail.com>
Date: Sun, 6 Oct 2019 00:43:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191005142050.8827-2-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> From: Li Guifu <blucerlee@gmail.com>
> 
> Large xattrs or xattrs shared by a lot of files
> can be stored in shared xattrs rather than
> inlined right after inode.
> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

Dear Gao Xiang,
   Should It need to add a configure parameter to 
cfg.c_inline_xattr_tolerance which is a custome threshold
of shared xattr ?
