Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6465B460F
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 13:34:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPrNg6rNPz3bc8
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 21:34:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rt56lu4z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.dk (client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=axboe@kernel.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rt56lu4z;
	dkim-atps=neutral
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPrNc4B6dz2ywS
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Sep 2022 21:34:08 +1000 (AEST)
Received: by mail-ej1-x631.google.com with SMTP id nc14so9883717ejc.4
        for <linux-erofs@lists.ozlabs.org>; Sat, 10 Sep 2022 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8Ag6mHz6RaJKAvIf3yWG8/NFxf6UdfL+MIDBEsLCyN8=;
        b=rt56lu4zDxtfFC0gCwopFBFWhVClMEv05ZLa6FVTJvWQfkY2PRelXahCVRkTH0W0EE
         SDi7Jg1T1Uk7Cgx8nOrb1llp4a5ljwV0hdWJLnKvHp44g8AGFKUUuXIYEu47fVHTnc+/
         8wGHkEV4bRaaeVojMOyW1sd84KJqpHyhoHmwKscMTML1EIFROO1ffCslzJIrMkPlYesA
         CBTvyvCmvmcJsItPrNfbGgD6LX3xXNlU+Uvr8Wo01rpF/CTHcxytcMd7P56VsFix0FeR
         nYU0jAzsSdPZvhNnm7dXkuhgwaXZBEfS/U1FJvc3Zvz9IP4l/XZZ4aGZLlBa7gaLGUT8
         q2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8Ag6mHz6RaJKAvIf3yWG8/NFxf6UdfL+MIDBEsLCyN8=;
        b=x3kHTjFMvobn5FKW0CLEuo/ucjyo66EPUdDp+Mq41DTHHR0REW88LY8Pvr6ua8ZW2o
         kywkt5HCKA8qrACXXO/SAZZPimuZxQGvIdJD2SmQeu2ZN4Phzr/VUTe7l4/cFL7qFDjt
         jwLCiqD9DdKL48VLAAGrfjXjJ6dXXd+pkePlt3Ak1OvT9ivS5u4Z4LrKk8VC0V4haSj4
         +C28/YGSpTwbS9xj9eSCXhlok6QJpQ0Tq7/Hsd1J8WD0ilEtcyeJsQTfgDO5i2cDI3B9
         E4Bfxi7kIwoZFK267I62IuWXsnRNHc/PF8JlCGPupZTCXg2kjOmkn+CPz/IRwVr3w7Ue
         NGdQ==
X-Gm-Message-State: ACgBeo0vWbw41xWnPVq9LxVum8i+5TC1y1/CN4/KH/bKkW9iKYYmwvxH
	eBDIN0IeV6HU1GnFMdkUP1aoogD5GNMI4wD6
X-Google-Smtp-Source: AA6agR6l/1o9KPVR6GtRSUN/6LhKnQUVR80O3xKSuOcDWQt5wKNsZnh3qcOtdZWGGeWimCE3wtzgXg==
X-Received: by 2002:a17:906:9750:b0:77b:6f08:986f with SMTP id o16-20020a170906975000b0077b6f08986fmr1210041ejy.416.1662809644338;
        Sat, 10 Sep 2022 04:34:04 -0700 (PDT)
Received: from [10.41.110.194] ([77.241.232.19])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402014100b0044e8d0682b2sm2014194edu.71.2022.09.10.04.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 04:34:03 -0700 (PDT)
Message-ID: <bcabe527-7940-8658-1728-28d64bd3cf80@kernel.dk>
Date: Sat, 10 Sep 2022 05:34:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan
 <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-2-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220910065058.3303831-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-mm@kvack.org, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 9/10/22 12:50 AM, Christoph Hellwig wrote:
> @@ -2390,8 +2392,13 @@ static int filemap_read_folio(struct file *file, filler_t filler,
>  	 * fails.
>  	 */
>  	folio_clear_error(folio);
> +
>  	/* Start the actual read. The read will unlock the page. */
> +	if (unlikely(workingset))
> +		psi_memstall_enter(&pflags);
>  	error = filler(file, folio);
> +	if (unlikely(workingset))
> +		psi_memstall_leave(&pflags);
>  	if (error)
>  		return error;

I think this would read better as:

  	/* Start the actual read. The read will unlock the page. */
	if (unlikely(workingset)) {
		psi_memstall_enter(&pflags);
		error = filler(file, folio);
		psi_memstall_leave(&pflags);
	} else {
		error = filler(file, folio);
	}
  	if (error)
  		return error;

-- 
Jens Axboe
