Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE9D50FA
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 18:29:23 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46r9JF33T2zDqZq
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Oct 2019 03:29:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gmPQo1Ih"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46r9J63VW1zDqZB
 for <linux-erofs@lists.ozlabs.org>; Sun, 13 Oct 2019 03:29:08 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id e10so3572506pgd.11
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2019 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=kNLvasFAyhQciOZHjgKw2sLAW0Ubeh75Bc+R7goYbOg=;
 b=gmPQo1Ihz4wm7WJawH0lmCsjJOeCgUhRKZiCKA46lELpx1p1cNL+cOtg3ouAtSVHEd
 g04GDtTVDeEjF0ntFxNltKNBoOaRYD8vfrcoEC7WqYTFOVkOmTCFbn2WRR8V6i3H8zyV
 ot9k662e/QCXDs+0qfzR+RaIKa94034z1R4uuftdKh3LSsznXzP/PDnF+TgvAAPMnZza
 ZY7I4HzWoOkIYdXohHtrTfdJthN8zTe5Lo4ZnF+pye4iYVyF2ZZh8CVRoi1Ue6jns+SE
 hGATh6fyldZpiaEWIVXIZUCaR3ZesHFST3NNAwknB/RkPwuMRRXK+eyf4fz+QQHASN7G
 ye6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=kNLvasFAyhQciOZHjgKw2sLAW0Ubeh75Bc+R7goYbOg=;
 b=PpWW2Z0F3yMzthhkATcCMUQwcw8ySZ4HuHEtiS3gl9X90MFHwOz3oyqnEQwsqaeR7m
 bq/XqWV3WjyxiV2OEdKXzhuu9EGlzXqXCggSQZdnRZglUpHp+CwWFkle7NT2+2T1LoK+
 PWMZ6iZUQBj86FhLG9S4afrHFpQxZNnhXCUiulaG5rTA4R5HzKgIoTFxn6ybg7BDrYLJ
 QDD9AeT3NEEVMJ54px64S4Ju0xsorta8nja5kkheIQErf0KH/bdj0ZqQreMfCxAd1fEc
 b9cHR3X8hB6Z4vbqK85BSYXJlclGLPSh8hgi9ot1ltidRT/blfCekQ2qVpQjv8h+09m5
 eAug==
X-Gm-Message-State: APjAAAXwFnnDlPm/SjGjoPa7+KrVi1ZD6B1Dgz4c+BYw+ZVASJkQp3M2
 KsO+8Mwyikgw6/Eut3smD/w=
X-Google-Smtp-Source: APXvYqwIRjtqhuJ+2VZ3VZgussd2UqbUzSfS9qxXK3BT74DmLvnQ6BZ9u2mQjI69PKuJ98iW34kryg==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id
 w14mr17140847pjn.61.1570897744481; 
 Sat, 12 Oct 2019 09:29:04 -0700 (PDT)
Received: from [0.0.0.0] (li2016-34.members.linode.com. [172.105.123.34])
 by smtp.gmail.com with ESMTPSA id g4sm11602744pfo.33.2019.10.12.09.28.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Oct 2019 09:29:03 -0700 (PDT)
Subject: Re: [PATCH] erofs-utils: fix old kernel compatibility for non-lz4
 compression
To: Gao Xiang <gaoxiang25@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191012024345.181737-1-gaoxiang25@huawei.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <f016bfce-c81d-96d7-5288-115f09aa6387@gmail.com>
Date: Sun, 13 Oct 2019 00:28:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191012024345.181737-1-gaoxiang25@huawei.com>
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

> If primary algorithm is not lz4 (e.g. compression
> off), clear EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> for old kernel (upstream kernel <= 5.2.y) compatibility.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---

Reviewed-by: Li Guifu <blucerlee@gmail.com>

Thanks,
