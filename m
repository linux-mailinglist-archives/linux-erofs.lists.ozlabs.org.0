Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1639E0E3B
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Dec 2024 22:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733176359;
	bh=IaZNJdNiqTC9Fp2cbi3B0hJ+CyjA6utopNG5kl7MHhM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YvbhZzIJNc07jf91JNvoIglS2k/ScAYSX3kkUuRL1xOwrHzWTFPKlOjLq4x62mGnb
	 j9wGafnQBgkdD2/R1TqWUGD9WsenGS3IN5csipc7jk+6MjNM8MdeM+LkLwrQKmREgP
	 rZgkP/qFFFOZ1ZhI6oCcUPyt8+jhrkqJgPWy5doD1Nv6kbqpIs/vPKfDL96d7G92jz
	 sh5exH+5WYHj1AFwaSha84s3c9x0b+gF7lR87VDcqyrRJBWVikfj8Nl5+gYvIMKraK
	 8aVYrO22Xbb/FOK05LPwBPHWM7qE9i3kNa9gvWvdSxsfVPecm6LzPh6eIjDpI4srNy
	 37g5z/tUgmZRA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2HZb0r9Pz2ydW
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 08:52:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733176357;
	cv=none; b=eXq3JmIBSRr/m3BZUogKKmRFxMRFKiJmEUkM5vSayuMmC9U/oF4FsyI0aCkk0ySf7+PowbmmRUHTZhkrGHtkRkKcrZR2CcrJ7N5wCjRJH443NSd+4q33YN83sjj1GZfs1y7tUXA7V5VLraEE8t60u55s6iF7WwjaNKf3G8Hm6k8J6+jgZb/E2F2FboKZjN+tonCoZvuo8vf2RZAdolSwY0RXA6JLkEL3wjvVcLYTRWucYO/y/dHe+skg+gGm8B+bE8ipt2P/EhTXokofkSKnQDRdConSr0/tCGVEPb4SNjPoFob6lJYsfWtuUxmlfh0cZcJpgdfGV6fRw3GUd048ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733176357; c=relaxed/relaxed;
	bh=IaZNJdNiqTC9Fp2cbi3B0hJ+CyjA6utopNG5kl7MHhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtB+igee/8M5M+liv9URkGGf2riXfxaV5BIwTbybn2OKqFC096Ut1W2YFTO6IYOcuRUB3V5FFeUiz126x1SozaglltR8TbW93aTWw7iMX59yMt8JDDTF1kosfh/g9orV94UyFlkb6ROIduXZ7/RhwZOF+vWsdmkRmpJj8tL4xbDOauXhLu16jJ7jf8luwV8Gl7ISNJa+lNSRoBzq1bwlZnQonFvVcf508BdcK/pJzrfIyZXTp9D0eXmEK05capH5MKwdDv0grgN+OTgVGhJPFGL8Ll2JEYcMlUq7LGf8cmprkRFzSM6rbGqeug2mpxE2uK3NQ1FLfQ+HqbhfLs7ngQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=tkZ6UJcn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=tkZ6UJcn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2HZX3QZmz2xtK
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 08:52:35 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-724f383c5bfso3668366b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Dec 2024 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733176352; x=1733781152; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IaZNJdNiqTC9Fp2cbi3B0hJ+CyjA6utopNG5kl7MHhM=;
        b=tkZ6UJcnb99F2XXQ/en4n3DAWgpbImJiVtg3/SIeI0UJ11BfUbI5mMeW+ouUX+9Pvh
         9uCZZenzzuQH9n5vbTj7PEKDBnsNGIegyLxZg/v+4jH+WUNq198L6xqSUToy3L/hjguU
         xDhRuGk8w771FEfYczbD73ULmUdpUxmHw1iEQrcByDE8Fwiz8uLXMVdFx4+0JU8vep+0
         KSeK6X2sfW3SOnApTzwV3HwMv1u6TheT6x88kPSWfON/pl/tuQOarsCk7HvUHeUPov4c
         VucuL4NRdWHo1cnE8e5aHZsOgWzife0p/zbprfd1Uc4o4Ub1qmhVjx8mKGZ5DrQ0DQ84
         W/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176352; x=1733781152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaZNJdNiqTC9Fp2cbi3B0hJ+CyjA6utopNG5kl7MHhM=;
        b=wew4gjyGHHb/wkn2Qm4M4cFX2w8ayz+fH/yHIrFCiAb2+uUeZeJ6hZFoD15mcZQ9gj
         i7tmWOczyBTDWiuvsm7c6J61CV4FIuwxIymf9+cfwsfA7NKBmechWNwSKPCZRjesoiHI
         lHfBpQrb+CeedVB6NZ8oMT0HPVy4bg12u6qMfTPAv3FE4MA/mzMYlaG8d5Zvo/i2vPhj
         YX4QkNmeOwHNON5Zdro0FlD8OLFuCv/RjSWjwa8oLVfcxJOMxNFT1dQERDesA2Ss4ZzG
         hBVvEGGxZtWOZOk3Qc87w+MxtaKSKU5fuGmlbUvRVFzC/2YQJdZfXrLlEIK8EwCMdjXS
         LyuQ==
X-Gm-Message-State: AOJu0YxlO8tAGnOnDvHt9d6eL2LvEv0xr3IOzTCxK9rl+G8MPocNypfQ
	VNYUk5WeJ2mVkObj9D5lYd/tEEoM1O3zBlimpfVmDPZrbSooP3xGUms/7ssVLkteYkXCuI6YtcF
	5gqtX46SugiJgegVq8u9GYvLgOzMZi3HTLKkT
X-Gm-Gg: ASbGncs+QXKNejhNpookZ30k2MSzEWnBuec9D6sILqS7LlBdLJLnYvGsUiXLckHCIHv
	ByVfnG6jkAnu4Yr2q2m5kcT41gW5eweY2OOT+Y9biGAsAelpnUu8vby9UbRJMkA==
X-Google-Smtp-Source: AGHT+IEWdhwsi+m1PH3AOfYF20b8Lk0d26QGk7Pos7WAG90X7d6QuROnvVXcRr2YlbgnPFHO7qose19PfbdhIFKIzT8=
X-Received: by 2002:a05:6a00:9289:b0:71e:44f6:6900 with SMTP id
 d2e1a72fcca58-72530133295mr31797470b3a.16.1733176352355; Mon, 02 Dec 2024
 13:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
Date: Mon, 2 Dec 2024 13:52:20 -0800
Message-ID: <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Looks good,

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
