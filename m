Return-Path: <linux-erofs+bounces-1107-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DEABA1918
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 23:35:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXn7f5MDMz2yqP;
	Fri, 26 Sep 2025 07:35:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1049"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758836126;
	cv=none; b=Ogj/lzlGQvGdkBTQCbfUfP+lBpbrXa4Nq1TQXogMo/AqtsNxlaXX4PPWm1Ztnf/I9TAKVAO8RD6OE5gZNSDiu88/SjNLh/R4Yz2EAokYYGVEJeuG6tB7MUKMYHP78/4Pqy6u/99JmPLlO4b6XGBRomVAc+rhuLgIcLtM1H+5Mp9Sq+uYBm5mKNTXiBtXA7KeWgNwDE3JVPR3r4tuKdKurPcy1S1FNy6RQm7ByjK0SawIShCUn9yzLV07eFJO3HEqyXzDL80U+yezR748KSIM3dl5v7+Vkmk8iGIE9pz5b71nv546zKr+5FDSV5zrjSucQUdNoFhg+1TBBPnKrhAl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758836126; c=relaxed/relaxed;
	bh=dyD0NvHQvKcjtkMWqtARFSwsGpym7n4r8JiRe/0tuUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N1RvJl1CjO0DV+idqhQtM9L+/XE01aOkUKGICP8qb76vmLnpGSVN+8zCjFlTzoXRFZMcKLfdac3m95UcJT+LnQGi4d2surduGkkClgQcpcdmjRxtGSMn4uP5F2tSTPd18CtHMLi08jv9Si4AtoSr2ExokMiRmGMR2w+mjlIYV6/pj3VCZ5f3aXqAmzoFAyiSd2YmVE1QUvhOBSKWIV4njYb+gl8yvF4rJC6cHJ1Q33vx3jOhOAshDUbC2MjCS4xIgzl9ZoV8hjS86mkyUfPc5PwQJjxmt5FvOrbGGjlceB8fwVA3wH6JZ4T0G/mqTV1MgqJG1BKj/TaqLqo0hLSdRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=eIDN8rnw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3mbxvaaykc6gamivrkowwotm.kwutqvcf-mzwnatqaba.whtija.wzo@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=eIDN8rnw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3mbxvaaykc6gamivrkowwotm.kwutqvcf-mzwnatqaba.whtija.wzo@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXn7c41MZz2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 07:35:23 +1000 (AEST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-3306543e5abso1409352a91.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758836122; x=1759440922; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyD0NvHQvKcjtkMWqtARFSwsGpym7n4r8JiRe/0tuUQ=;
        b=eIDN8rnw5Km+Vuag5DHbMfz7bQom/KrZAUUMs4SInBx+bjXKtit5e4e5xkQOm48bjJ
         j8faSHVdwCAR27y3PZJTqO6N7Q6KMjMNE6KF82FajlIsvkM+KfM7JV3t8qXFQxhEbiw7
         wQmvCGgPSAdPykZ5Sx6qCueAbeqfTCJwCVFGNDDjKlidenMG+U+G98fS24oeoy4HcJvz
         R2R/3CVCwjGRFXMWqfprtVR3O68LYqx3/0QXHW+CTUN6lKtnFLQ9PQoBgCRvotEVD7kM
         3LyRGu12sd9hqfm3C/Aa5es/RarqR48mpUZHXBaIUfzu2CIF0sA5GEtOJPGtACZqVuxK
         H24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758836122; x=1759440922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyD0NvHQvKcjtkMWqtARFSwsGpym7n4r8JiRe/0tuUQ=;
        b=IIXZpKLInQKgz2ml6Q3HeCuhKuPC8AJhhK9cn2FVTAnFY2bnub9fhGLWmJ9D8RjM+K
         E6n2LRWOrB74tUKVxGnOiR0BF6Eg4No0yUfe8DuaaksBq0eThS6X/pEZgDPgZcccTDi3
         2eBpoduvYslWv3dKjcV7gjCHbzt1Wzp6y4pH5d++HJQslR8dCvQ027Qm4ASYAy44ucgq
         m9Wp9lHAxwLq1QctQvKZx+ny6a4PLOlZe5tGnnWqq4k9IQI0z6FDn8yL9m44b2ehbf7H
         bmkTEkJxkE+R1iJb9pHTV8D6+kn8thWigV4SpvaclalWms/nIKnlLUQ9njUiVaAiGTKx
         E+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhPKDRTVCHN+Bc8U7FjbLkhhXeVdHRPGbZ6QJF2zmxHa7eky/EK5dEgHpUKEkrGwYGgTUUhJwQJXU5sw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxyQZ3mzl91gmWE+o3AvJsQCCOJ1pjukzEQvCOVsolQ0+IoI2zO
	wW1DgFdj9hwKo/UpKP4HCfgcwJoTbef+QaHOBzK2Hi+JbGMrIRfr7uncmomICOMMVd3yQno4cjt
	oKgsXdw==
X-Google-Smtp-Source: AGHT+IEF46Ap3+CoFy4DNwHeeqPSdM0QIu1/iWB0NVseFrH0JqhT9O+vdtR7XjCf1sCWIaN5eWCQMso96V4=
X-Received: from pjj5.prod.google.com ([2002:a17:90b:5545:b0:330:6cf5:5f38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c07:b0:32e:ca60:6bd7
 with SMTP id 98e67ed59e1d1-334568960d8mr4094341a91.11.1758836121051; Thu, 25
 Sep 2025 14:35:21 -0700 (PDT)
Date: Thu, 25 Sep 2025 14:35:19 -0700
In-Reply-To: <20250827175247.83322-10-shivankg@amd.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-10-shivankg@amd.com>
Message-ID: <aNW1l-Wdk6wrigM8@google.com>
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org, chao@kernel.org, 
	jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com, 
	kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, tabba@google.com, 
	ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org, 
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com, 
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, 
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Aug 27, 2025, Shivank Garg wrote:
> Add tests for NUMA memory policy binding and NUMA aware allocation in
> guest_memfd. This extends the existing selftests by adding proper
> validation for:
> - KVM GMEM set_policy and get_policy() vm_ops functionality using
>   mbind() and get_mempolicy()
> - NUMA policy application before and after memory allocation
> 
> These tests help ensure NUMA support for guest_memfd works correctly.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 90f03f00cb04..c46cef2a7cd7 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -275,6 +275,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
>  	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
>  
>  LDLIBS += -ldl
> +LDLIBS += -lnuma

Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
any of my <too many> systems, and I doubt I'm alone.  Installing the package is
trivial, but I'm a little wary of foisting that requirement on all KVM developers
and build bots.

I'd be especially curious what ARM and RISC-V think, as NUMA is likely a bit less
prevelant there.

>  LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
>  
>  LIBKVM_C := $(filter %.c,$(LIBKVM))
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index b3ca6737f304..9640d04ec293 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -7,6 +7,8 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <numa.h>
> +#include <numaif.h>
>  #include <errno.h>
>  #include <stdio.h>
>  #include <fcntl.h>
> @@ -19,6 +21,7 @@
>  #include <sys/mman.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/syscall.h>
>  
>  #include "kvm_util.h"
>  #include "test_util.h"
> @@ -72,6 +75,122 @@ static void test_mmap_supported(int fd, size_t page_size, size_t total_size)
>  	TEST_ASSERT(!ret, "munmap() should succeed.");
>  }
>  
> +#define TEST_REQUIRE_NUMA_MULTIPLE_NODES()	\
> +	TEST_REQUIRE(numa_available() != -1 && numa_max_node() >= 1)

Using TEST_REQUIRE() here will result in skipping the _entire_ test.  Ideally
this test would use fixtures so that each testcase can run in a child process
and thus can use TEST_REQUIRE(), but that's a conversion for another day.

Easiest thing would probably be to turn this into a common helper and then bail
early.

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 9640d04ec293..6acb186e5300 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -7,7 +7,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <numa.h>
 #include <numaif.h>
 #include <errno.h>
 #include <stdio.h>
@@ -75,9 +74,6 @@ static void test_mmap_supported(int fd, size_t page_size, size_t total_size)
        TEST_ASSERT(!ret, "munmap() should succeed.");
 }
 
-#define TEST_REQUIRE_NUMA_MULTIPLE_NODES()     \
-       TEST_REQUIRE(numa_available() != -1 && numa_max_node() >= 1)
-
 static void test_mbind(int fd, size_t page_size, size_t total_size)
 {
        unsigned long nodemask = 1; /* nid: 0 */
@@ -87,7 +83,8 @@ static void test_mbind(int fd, size_t page_size, size_t total_size)
        char *mem;
        int ret;
 
-       TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+       if (!is_multi_numa_node_system())
+               return;
 
        mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
        TEST_ASSERT(mem != MAP_FAILED, "mmap for mbind test should succeed");
@@ -136,7 +133,8 @@ static void test_numa_allocation(int fd, size_t page_size, size_t total_size)
        char *mem;
        int ret, i;
 
-       TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+       if (!is_multi_numa_node_system())
+               return;
 
        /* Clean slate: deallocate all file space, if any */
        ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 23a506d7eca3..d7051607e6bf 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -21,6 +21,7 @@
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 
+#include <numa.h>
 #include <pthread.h>
 
 #include "kvm_util_arch.h"
@@ -633,6 +634,11 @@ static inline bool is_smt_on(void)
        return false;
 }
 
+static inline bool is_multi_numa_node_system(void)
+{
+       return numa_available() != -1 && numa_max_node() >= 1;
+}
+
 void vm_create_irqchip(struct kvm_vm *vm);
 
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,

