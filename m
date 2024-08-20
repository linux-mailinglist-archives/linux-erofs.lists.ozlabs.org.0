Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D467958DD9
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 20:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724177699;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ng/U1T2X4mkuuuu6CKi0wI3T7WMm4HOSfZ7PSTQ8QcEtRM9oDeSjOnfLEl/JrA2Bp
	 +y/1YzozOPjWzN5o4k/nuHZNF7z2B+1dp6b9NRRLWdSzV7GXCfF5+RedM1loAgjOxM
	 h0hrnmu9+poanDZBovku3izCnuSWyakR2GfD6e2AfrjB+sSmcy1TmaJGXan+nr/WRR
	 yofOMIIOj+/msy4ytSi91xJbtT/Xm7SAEBjxV1JZ4U9O7E9NSq18gPG/KS9cNEIDRF
	 /3k6lX0RtIfRDR351n5u7u5ywhu/6Ga04b/5vrO3dmdSuJrfHa1MPXUvJ1/fwSpKSK
	 1shok4juUqhyg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpHgR4vGrz2yMP
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 04:14:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=lnyswN26;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpHgN0ZLfz2xGs
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 04:14:55 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3718c176ed7so2777501f8f.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724177689; x=1724782489; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=lnyswN26oC9gXnnrm+uQ5fAdl5v5RcueyzwhW0x3ooZdCKW8U4pm81ZzRb7PmEj1v/
         lL5gsHTNb4UqJTitxmhcQTpqksDvaKWq4CwWVqy/IX6SILsPHU/MbZZSmKo5akaRG1uq
         vOtZQuaEp6J6eAGrA9oqiquVUo3S9+6IboNA+jvXnRkvcK/8YyTO60ggK0boj3qXd8UO
         88kuwu8rkmS2rc32dT/9/LS49PkEKoigJ+qHP0L94GgBw4fHAyu7uKMXiDOcKsNNkIku
         NLj2ShLJohdZKy84KYtIekeZX/LINbj79OW6VTaNvRkK9JRy4mdfXiEQjAtZoNIii5Gt
         +bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724177689; x=1724782489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=cNBl6gTPHY6ooTb7a06tx8lwR27Kx/u5C+Sgjf3/Rc5GY9sR54LKSmQN9NbwHMIgoN
         2V1Sw8ACyUHAPgrWENtzt+As8ORlCIzFgjXyMUJHtKnyIDlivVjEQFRPGRNBxpXZjlgT
         NQ/WyALieZYZvX8UIvqsjK+tl4oHQ9TDmqXNOuJSA/Zu3sAlvVb1QWSfVBw6PKb6yhOl
         8opCcZ58orUjn2KYrnRDCw6SHSU8JDYJ1NZmS6x+imXX6MIhq6+1k0Dvhk/2RrRWzhft
         kZGTXxWo095flxMZj/ZX2FTLnWJjQH9QX1KPQE1+L06D6e8pAfzQnN/d2u5HuYclET4V
         vtlg==
X-Gm-Message-State: AOJu0YwtQpC/Ki9jAGP6H40tBHlR78cyojWuSfSPsU7stGDMSy2NdDjO
	vwURt6KmoyAQC0N6aFGGtziG9YgHJ5DIp1L/RtBDNSyXMjSa/M3OMxuS4lmvXGOdSM3XS+Xm9rz
	uUchd2mpcxAM1GnOcbwi/RfIoj60lTDv2hq9F
X-Google-Smtp-Source: AGHT+IHmbKSFe4B1/1TnoT1W3TvVcJzc2fL1GZV//LexmxlmcbOZiG/FdzVIHlK0+AXA6ItiI5sA+LO8mRK53OYMBOE=
X-Received: by 2002:adf:a2da:0:b0:371:8e8b:39d4 with SMTP id
 ffacd0b85a97d-3719464cd9dmr10782209f8f.28.1724177688981; Tue, 20 Aug 2024
 11:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f7b96e062018c6e3@google.com> <20240820085619.1375963-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240820085619.1375963-1-hsiangkao@linux.alibaba.com>
Date: Tue, 20 Aug 2024 11:14:37 -0700
Message-ID: <CAB=BE-RDih_Ng0cCCHgmQ8+29yj+kKHZheyoLKEDEnPC=tJjhg@mail.gmail.com>
Subject: Re: [PATCH RESEND] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com, Chunhai Guo <guochunhai@vivo.com>, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
