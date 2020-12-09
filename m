Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C02D38ED
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 03:44:45 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrLx65Hk1zDqkg
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 13:44:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HAf6wGq7; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAf6wGq7; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrLx12XK4zDqQG
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 13:44:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607481870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4jgdijS0C1lI8z3HE4fifcsU85m3/IComKA3GzeTSg=;
 b=HAf6wGq7qq2FjK0XgpfGThmU6/zvrXIymw9KaxE1GLvURH9/DuQxJ+bL5CJaqb9hwKkFIo
 ogFJbeHYRQs5u8XqstaiPwK/zQaK039idjNGW5YZorvyuwBaqBuMUFRp9sdEjboJhKVYuE
 2Ekw3OSJPhef5QQEvdMMByMbrV7EExY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607481870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4jgdijS0C1lI8z3HE4fifcsU85m3/IComKA3GzeTSg=;
 b=HAf6wGq7qq2FjK0XgpfGThmU6/zvrXIymw9KaxE1GLvURH9/DuQxJ+bL5CJaqb9hwKkFIo
 ogFJbeHYRQs5u8XqstaiPwK/zQaK039idjNGW5YZorvyuwBaqBuMUFRp9sdEjboJhKVYuE
 2Ekw3OSJPhef5QQEvdMMByMbrV7EExY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208---M0igPnNxmG_B1Mj6gVmg-1; Tue, 08 Dec 2020 21:44:28 -0500
X-MC-Unique: --M0igPnNxmG_B1Mj6gVmg-1
Received: by mail-pl1-f199.google.com with SMTP id w9so58379plp.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 18:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=w4jgdijS0C1lI8z3HE4fifcsU85m3/IComKA3GzeTSg=;
 b=fbrlO2nTXUa4U2RSs0U+NMp3RlzTYrL2dtsv6ifnRYBctpdF3DiqmQT81DgaAV/Fqt
 8QGQOArkfLmq1xdOkmFef+PA0KVWCj9IpcP9bm5nDu64FDedlucXe3NcWEm95Qxt7Uq3
 ZGClzRKFxXld62zCg3b2cvkZ4tXYDz9eYjl1Yt2j0atyWo3Eq3dy0W1/9oZv5f1l34fJ
 QL76NFro10ameqnjzeLkIecFRkPNSEPO4IEd0mR6xJcadoiX4ruVMgwM61ixDdQ4QQ7f
 FYmDav9RYpGGyQQheMSCuO/jzgjSKSInh8YFpMAr/XfjJsp0gRji0p5euVIQZIdq6Wns
 EOGQ==
X-Gm-Message-State: AOAM531vMHky8IXsbVEQPMcwoqPy1FpHRX6J1Cy6dtDVYM7P/5AdjNKk
 O8s2Un9Nz+9FocXDuBBhHD3fG37PvF68cgyWYr1i8NoRKb7eT+ks8GRz69EnsvEyMsurrX4gnUI
 9RCtDhjGwMs8NfuAlXARF5Wlw
X-Received: by 2002:aa7:957c:0:b029:19e:3b88:de7e with SMTP id
 x28-20020aa7957c0000b029019e3b88de7emr360519pfq.31.1607481867111; 
 Tue, 08 Dec 2020 18:44:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMA3nZaD1PHUZhLI+Wkx8wEq55n9kh/F/ycdNZ/qmy5jdTrb7Mdm1OYixeCFytHfe3JRZhCw==
X-Received: by 2002:aa7:957c:0:b029:19e:3b88:de7e with SMTP id
 x28-20020aa7957c0000b029019e3b88de7emr360494pfq.31.1607481866787; 
 Tue, 08 Dec 2020 18:44:26 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y24sm177397pfn.176.2020.12.08.18.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 18:44:26 -0800 (PST)
Date: Wed, 9 Dec 2020 10:44:15 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] erofs: avoiding using generic_block_bmap
Message-ID: <20201209024415.GA33948@xiangao.remote.csb>
References: <20201208131108.7607-1-huangjianan@oppo.com>
 <c71fe6a9-06ba-3871-6e0b-104f58df1df7@oppo.com>
MIME-Version: 1.0
In-Reply-To: <c71fe6a9-06ba-3871-6e0b-104f58df1df7@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan and Chao,

On Wed, Dec 09, 2020 at 10:34:54AM +0800, Huang Jianan wrote:
> 
> 在 2020/12/8 21:11, Huang Jianan 写道:

...

> > -
> >   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> >   {
> >   	struct inode *inode = mapping->host;
> > +	struct erofs_map_blocks map = {
> > +		.m_la = blknr_to_addr(iblock),
> 
> Sorry for my mistake, it should be:
> 
> .m_la = blknr_to_addr(block),
>

Sigh, since my ro_fsstress doesn't cover bmap interface... I mean do we need
to add some testcase for this? (But it needs to be fixed anyway, plus this patch
looks good to me....)

Hi Chao,
could you kindly leave some free slot for this patch and

erofs: force inplace I/O under low memory scenario
https://lore.kernel.org/r/20201208054600.16302-1-hsiangkao@aol.com

Since I'd like to merge these all for 5.11-rc1 (so we could have more time to
test until the next LTS version), since 5.10 is a LTS version, I tend to not
introduce any big modification (so in the past months, "erofs: force inplace
I/O under low memory scenario" never upstreamed at all.)

Thanks,
Gao Xiang


