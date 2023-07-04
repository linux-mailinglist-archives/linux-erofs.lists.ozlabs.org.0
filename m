Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E474739D
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 16:06:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwPjY05kPz3bNp
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 00:06:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.172; helo=mail-pl1-f172.google.com; envelope-from=bart.vanassche@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwPjQ4Zwhz2yHs
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 00:06:33 +1000 (AEST)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b8062c1ee1so44494075ad.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Jul 2023 07:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479590; x=1691071590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV2SCOEdB9t0w6tigDexjJMYhGF54ZwsLlYmJ1gE7wU=;
        b=U+k1URnhQRpPnU6r6FO0g6QtfKXT/FpC78EiFjWR+0bwRGyvX2MfDVW/sYwre9aRFB
         sDzm1Jnc6pMdPVehDOdkQaPkv+Oa24wHSGULBT2jVIzRadnPIK6fGKXHgJU4Dq5SB8rF
         k+suA8ZTkA98rDvs+l68IdYLXXcA6o0h+9dH3dl52zMjfehYarx9xeNHXJQJm3Q9tXJp
         7rhsUc0rZNkwrNfiXHH/nJ1ryri5IjQjJ6QxL8/SkboId4t66ut/7EPrhNy1HBod5gAz
         OIAuSB+FJ6Zgzz1TZs5o5ExIwicFbfmtnoc/5DGmYTI5ZRjbL4I6KAHt3P0mNR0vArip
         CMHQ==
X-Gm-Message-State: ABy/qLZvKajHhAad7vNJbrT7OdUSLUjgkV3+sWAZ2zyMVH5tHRJgDRYs
	u7gvheVe0VpILiNoz4BqHxQ=
X-Google-Smtp-Source: APBJJlEESj5502hCCjnCrW5aNdhMviGxH5NXIz8SFwBF+614aVB6e0+1hJtWMTw8TJzZNuQy8olTNg==
X-Received: by 2002:a17:903:447:b0:1b8:a31b:ac85 with SMTP id iw7-20020a170903044700b001b8a31bac85mr2719760plb.41.1688479589749;
        Tue, 04 Jul 2023 07:06:29 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id jk4-20020a170903330400b001b672af624esm13083569plb.164.2023.07.04.07.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:06:29 -0700 (PDT)
Message-ID: <bb91e76b-0bd8-a949-f8b9-868f919ebcb9@acm.org>
Date: Tue, 4 Jul 2023 07:06:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230704122224.16257-1-jack@suse.cz>
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
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, "Darrick J. Wong" <djwong@kernel.org>, linux-nvme@lists.infradead.org, Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, Jack Wang <jinpu.wang@ionos.com>, Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xenproject.org, Christian Borntraeger <borntraeger@linux.ibm.com>, Kent Overstreet <kent.overstreet@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Joern Engel <joern@lazybastard.org>, reiserfs-devel@vger.kernel.org, linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Trond Myklebust <trond.myklebust@hammersp
 ace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, linux-mm@kvack.org, Song Liu <song@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 7/4/23 05:21, Jan Kara wrote:
> +struct bdev_handle {
> +	struct block_device *bdev;
> +	void *holder;
> +};

Please explain in the patch description why a holder pointer is 
introduced in struct bdev_handle and how it relates to the bd_holder 
pointer in struct block_device. Is one of the purposes of this patch 
series perhaps to add support for multiple holders per block device?

Thanks,

Bart.

