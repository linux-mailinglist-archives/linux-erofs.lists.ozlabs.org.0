Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEF3E1F6E
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 17:37:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yvdH4kv7zDqQY
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2019 02:37:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rvKMLNyf"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yvd94dSnzDqLf
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Oct 2019 02:37:17 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y8so1753537plk.0
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jSfYldH3w1vSdq2DtKulO6vfuiEMXC+f8VeX3nn3l94=;
 b=rvKMLNyfpudvRxrKaImQPxzOZ7gSNlMrigIxSgD1OEqNcDHtduMIwceUvTTmSV3Cj7
 pg4tTDungJTUfSiXw5jMMhhZGKUs4ON61vxCfQxHJaJwlGUX3JmEJ5IjqTyLJCVRlsZ2
 FJa0WaFQFsGoTiOr/gTX6F+5cFOJo8hq1bCrA2S6roIq4zcsuDMFzFOoyI5Yi+UPthKp
 fSre9imxhlW3BeLgl/Pnwc5z8/JEJvP1Jg2iiSWENYyxCDhLl9tOsxVi06NuHApxlm88
 mkw4LZUfCV6lo2bQANqe74Gz5T8WdEg039tQ4vcWF/kfzPw61VyBFp4Al7LlguFErTNf
 13HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jSfYldH3w1vSdq2DtKulO6vfuiEMXC+f8VeX3nn3l94=;
 b=oHZ2yKzB7HW343+72uVgGuzSFMVVQzvttildV7EMFDoKXa8Nw99HRCFAo+ROpBc/0J
 DHnOPJC0CFSO6tjyJQV73tYmUaGzT44lVpYfHRNqfzw2XUieQgDYjTXuRDVmsKibo0ke
 tlOY2aWX8pNE2kb2Ekz8+ZbXqljbIEQ6WYsDp5HGnPr91Jp7uQZsjBBCUwq5ELQlO5lx
 KkGz5EGKkJLoInJiOY/Spv9XmdsJ0ztkoFAPb+tNXYvDOVxUa1xTrCKFceis4XKwNwpL
 4QFw5dBADWo3XovqxX/ZLq0LoN1Og9cjLvrZJCFhg2FBM5GxpSf5rt4DNB1+wSuAswyA
 cDbg==
X-Gm-Message-State: APjAAAXtU8ZSRS5uYK/Q1HArJHo6TX7wMDIM+q6GQ4VAs1a1PfyH4QBE
 JzRoyrSOkmPUFFDy0buGzmE=
X-Google-Smtp-Source: APXvYqzmZpuQTLQC4bCGkkxFkMrfl4tdKvzkyC0ToQqzLdRLWZ/caw983NBW906ye4Jr4hzXQbaxkw==
X-Received: by 2002:a17:902:9347:: with SMTP id
 g7mr10314483plp.291.1571845034555; 
 Wed, 23 Oct 2019 08:37:14 -0700 (PDT)
Received: from [0.0.0.0] (li1104-154.members.linode.com. [45.79.5.154])
 by smtp.gmail.com with ESMTPSA id b4sm19671191pju.16.2019.10.23.08.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 08:37:13 -0700 (PDT)
Subject: Re: [PATCH] erofs-utils: document more known matters to README
To: Gao Xiang <gaoxiang25@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191023092031.211186-1-gaoxiang25@huawei.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <cd5a46dc-30aa-ce3b-6b44-e38df4dbb328@gmail.com>
Date: Wed, 23 Oct 2019 23:37:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023092031.211186-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: Yann Collet <yann.collet.73@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/10/23 17:20, Gao Xiang wrote:
> We are about to release erofs-utils 1.0, add more words
> to README on known fixed issues about lz4 upstream library.
> 
> Cc: Li Guifu <bluce.liguifu@huawei.com>
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: Yann Collet <yann.collet.73@gmail.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

It looks good
Reviewed-by: Li Guifu <blucerlee@gmail.com>

Thanks,
